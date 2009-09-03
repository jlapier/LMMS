# == Schema Information
# Schema version: 20090807161933
#
# Table name: quiz_questions
#
#  id                :integer       not null, primary key
#  quiz_page_id      :integer       
#  title             :string(255)   
#  position          :integer       
#  body              :text          
#  explanation       :text          
#  correct_answer_id :integer       
#  created_at        :datetime      
#  updated_at        :datetime      
# (end schema)
class QuizQuestion < ActiveRecord::Base
  belongs_to :quiz_page
  belongs_to :correct_answer, :class_name => 'QuizAnswer', :foreign_key => 'correct_answer_id'

  has_many :quiz_answers

  validates_presence_of :body, :quiz_page_id

  attr_accessor :answers_string

  acts_as_list

  after_save :parse_answers_string

  # only ready if you've given some answers and one of them is the "correct" answer
  def is_ready?
    !quiz_answers.empty? and !correct_answer.nil?
  end

  def after_find
    self.answers_string = quiz_answers.map(&:body).join("\n")
  end


  private

  def parse_answers_string
    unless answers_string.blank?
      first = true
      new_qas = []
      for ans_line in answers_string.split("\n").map(&:strip).select { |s| !s.blank? }
        qa = QuizAnswer.find_or_create :body => ans_line, :quiz_question => self
        self.correct_answer_id = qa.id if first
        new_qas << qa
        first = false
      end
      # delete any answers no longer in list
      (quiz_answers - new_qas).map(&:destroy)
      # blank out answers_string so this callback isn't triggered again
      self.answers_string = nil
      save
    end
  end
end
