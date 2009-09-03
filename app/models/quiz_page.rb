# == Schema Information
# Schema version: 20090807161933
#
# Table name: quiz_pages
#
#  id                        :integer       not null, primary key
#  section_id                :integer       
#  title                     :string(255)   
#  position                  :integer       
#  setup_body                :text          
#  created_at                :datetime      
#  updated_at                :datetime      
#  layout_image_file_name    :string(255)   
#  layout_image_content_type :string(255)   
#  layout_image_file_size    :integer       
#  layout_image_updated_at   :datetime      
#  layout_image_alt_text     :string(255)   
# (end schema)
class QuizPage < ActiveRecord::Base
  belongs_to :section

  has_many :quiz_questions, :order => 'position'

  validates_presence_of :section_id

  acts_as_list

  has_attached_file :layout_image, :styles => { :original => ["350x425", :jpg], :thumb => ["200x200", :jpg] }

  include ActionView::Helpers::TextHelper

  def title_in_list
    title.blank? ? truncate(HTML::FullSanitizer.new.sanitize(setup_body), :length => 70) : title
  end


  # provide question_hash like: { question id => answer id }
  # ex: { 1 => 23, 2 => 27, 3 => 35 }
  def score(question_hash)
    return nil unless question_hash and question_hash.size > 0
    correct_count = 0
    question_hash.each do |q_id, a_id|
      quiz_question = quiz_questions.find(q_id)
      if quiz_question and quiz_question.correct_answer_id == a_id
        correct_count += 1
      end
    end
    100 * correct_count / quiz_questions.size
  end
end
