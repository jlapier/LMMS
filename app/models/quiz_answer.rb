# == Schema Information
# Schema version: 20090807161933
#
# Table name: quiz_answers
#
#  id               :integer       not null, primary key
#  quiz_question_id :integer       
#  body             :text          
#  created_at       :datetime      
#  updated_at       :datetime      
# (end schema)

class QuizAnswer < ActiveRecord::Base
  belongs_to :quiz_question

  validates_presence_of :body, :quiz_question_id

  class << self
    def find_or_create(atts)
      qa = find :first, :conditions => { :body => atts[:body], :quiz_question_id => atts[:quiz_question].id }
      if qa
        return qa
      else
        return create(atts)
      end
    end
  end
end
