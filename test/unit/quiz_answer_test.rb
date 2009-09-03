require 'test_helper'

class QuizAnswerTest < ActiveSupport::TestCase
  def setup
    @quiz_question = QuizQuestion.find :first
  end

  test "create answer" do
    qa = QuizAnswer.new :quiz_question => @quiz_question, :body => "This is an answer"
    assert qa.valid?, qa.errors.full_messages
    assert qa.save, qa.errors.full_messages
  end

  test "find or create" do
    qa1 = QuizAnswer.create :quiz_question => @quiz_question, :body => "This is an answer"
    qa2 = QuizAnswer.find_or_create :quiz_question => @quiz_question, :body => "This is an answer"
    assert qa2.valid?, qa2.errors.full_messages
    assert_equal qa1, qa2
  end

  test "should test fixtures" do
    obs = QuizAnswer.find :all
    assert obs.size > 0
    for ob in obs
      assert ob.valid?
    end
  end
end
