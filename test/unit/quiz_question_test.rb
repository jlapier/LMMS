require 'test_helper'

class QuizQuestionTest < ActiveSupport::TestCase
  def setup
    @quiz_page = QuizPage.find :first
    @atts = { :quiz_page => @quiz_page, :body => "This is a question", :explanation => "The answer is that because." }
  end

  test "create quiz question" do
    qq = QuizQuestion.new @atts
    assert qq.valid?, qq.errors.full_messages
    assert qq.save, qq.errors.full_messages
    assert !qq.is_ready?
  end

  test "quiz question with correct answer should be ready" do
    qq = QuizQuestion.create @atts
    qa = QuizAnswer.create :quiz_question => qq, :body => 'good answer'
    qq.correct_answer = qa
    assert qq.save, qq.errors.full_messages
    assert qq.is_ready?
  end

  test "quiz question with answer string should parse" do
    qq = QuizQuestion.new @atts.merge( :answers_string => "Best Answer\nWrong Answer A\n Wrong Answer B\n\n")
    assert qq.save, qq.errors.full_messages
    qq.reload
    assert !qq.quiz_answers.empty?
    assert_equal qq.quiz_answers.map(&:body).sort, ["Best Answer", "Wrong Answer A", "Wrong Answer B"].sort
    assert_not_nil qq.correct_answer
    assert_equal qq.correct_answer.body, "Best Answer"
    assert qq.is_ready?
  end

  test "quiz question with answer string should delete old answers" do
    qq = QuizQuestion.new @atts.merge( :answers_string => "Best Answer\nWrong Answer A\n Wrong Answer B\n\n")
    assert qq.save, qq.errors.full_messages
    qq.reload
    qq = QuizQuestion.new @atts.merge( :answers_string => "Best Answer\n Wrong Answer B\n\n")
    assert qq.save, qq.errors.full_messages
    qq.reload
    assert !qq.quiz_answers.empty?
    assert_equal qq.quiz_answers.map(&:body).sort, ["Best Answer", "Wrong Answer B"].sort
    assert_not_nil qq.correct_answer
    assert_equal qq.correct_answer.body, "Best Answer"
    assert qq.is_ready?
  end

  test "quiz question should have answers and they should show up in the answers string" do
    qq = quiz_questions(:one)
    assert !qq.quiz_answers.empty?
    assert !qq.answers_string.blank?
  end


  test "should test fixtures" do
    obs = QuizQuestion.find :all
    assert obs.size > 0
    for ob in obs
      assert ob.valid?
    end
  end
end
