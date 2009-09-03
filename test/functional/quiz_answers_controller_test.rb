require 'test_helper'

class QuizAnswersControllerTest < ActionController::TestCase

=begin


  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiz_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz_answer" do
    assert_difference('QuizAnswer.count') do
      post :create, :quiz_answer => { }
    end

    assert_redirected_to quiz_answer_path(assigns(:quiz_answer))
  end

  test "should show quiz_answer" do
    get :show, :id => quiz_answers(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => quiz_answers(:one).id
    assert_response :success
  end

  test "should update quiz_answer" do
    put :update, :id => quiz_answers(:one).id, :quiz_answer => { }
    assert_redirected_to quiz_answer_path(assigns(:quiz_answer))
  end

  test "should destroy quiz_answer" do
    assert_difference('QuizAnswer.count', -1) do
      delete :destroy, :id => quiz_answers(:one).id
    end

    assert_redirected_to quiz_answers_path
  end

=end

end
