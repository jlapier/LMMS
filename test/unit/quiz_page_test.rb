require 'test_helper'

class QuizPageTest < ActiveSupport::TestCase
  def setup
    @learning_module = LearningModule.find :first
    @section = @learning_module.sections.first
    @atts = { :section => @section, :title => "Test title" }
  end

  test "should create section" do
    qp = QuizPage.new @atts
    assert qp.valid?, qp.errors.full_messages
    assert qp.save, qp.errors.full_messages
  end

  test "should test fixtures" do
    obs = QuizPage.find :all
    assert obs.size > 0
    for ob in obs
      assert ob.valid?
    end
  end

  test "should calculate score" do
    qp = quiz_pages(:one)
    assert_equal qp.quiz_questions.size, 2
    first_correct = qp.quiz_questions[0].correct_answer
    first_wrong = qp.quiz_questions[0].quiz_answers.detect { |qa| qa != qp.quiz_questions[0].correct_answer }
    second_correct = qp.quiz_questions[1].correct_answer
    second_wrong = qp.quiz_questions[1].quiz_answers.detect { |qa| qa != qp.quiz_questions[1].correct_answer }
    assert_not_nil first_correct
    assert_not_nil first_wrong
    assert_not_nil second_correct
    assert_not_nil second_wrong
    hundred = { qp.quiz_questions[0].id => first_correct.id, qp.quiz_questions[1].id => second_correct.id }
    fifty =   { qp.quiz_questions[0].id => first_wrong.id, qp.quiz_questions[1].id => second_correct.id }
    zero =    { qp.quiz_questions[0].id => first_wrong.id, qp.quiz_questions[1].id => second_wrong.id }
    assert_equal 100, qp.score(hundred)
    assert_equal 50, qp.score(fifty)
    assert_equal 0, qp.score(zero)
  end
end
