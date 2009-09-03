require 'test_helper'

class QuizQuestionsControllerTest < ActionController::TestCase
  def setup
    @learning_module = LearningModule.find :first
    @section = @learning_module.sections.first
    @quiz_page = @section.quiz_pages.first
    @bulk_params = { :learning_module_id => @learning_module.id, :section_id => @section.id, :quiz_page_id => @quiz_page.id }
  end

  test "should get index" do
    get :index, @bulk_params
    assert_response :success
    assert_not_nil assigns(:quiz_questions)
  end

  test "should get new" do
    login_as(:quentin)
    get :new, @bulk_params
    assert_response :success
  end

  test "should create quiz_question" do
    login_as(:quentin)
    assert_difference('QuizQuestion.count') do
      post :create, @bulk_params.merge(:quiz_question => { :title => 'Qqqq', :body => 'pbj sammiches!' })
    end

    assert_redirected_to learning_module_section_quiz_page_quiz_questions_path(@learning_module, @section, @quiz_page)
  end

  test "should redirect to question list instead of showing one quiz_question" do
    get :show, @bulk_params.merge(:id => quiz_questions(:one).id)
    assert_redirected_to learning_module_section_quiz_page_quiz_questions_path(@learning_module, @section, @quiz_page)
  end

  test "should get edit" do
    login_as(:quentin)
    get :edit, @bulk_params.merge(:id => quiz_questions(:one).id)
    assert_response :success
  end

  test "should update quiz_question" do
    login_as(:quentin)
    put :update, @bulk_params.merge(:id => quiz_questions(:one).id, :quiz_question => { :title => 'Pppp', :body => 'ham sammiches!' })
    assert_redirected_to learning_module_section_quiz_page_quiz_questions_path(@learning_module, @section, @quiz_page)
  end

  test "should destroy quiz_question" do
    login_as(:quentin)
    assert_difference('QuizQuestion.count', -1) do
      delete :destroy, @bulk_params.merge(:id => quiz_questions(:one).id)
    end

    assert_redirected_to learning_module_section_quiz_page_quiz_questions_path(@learning_module, @section, @quiz_page)
  end

  test "should get answer and save chosen answer in session" do
    xhr :post, :get_answer, @bulk_params.merge(:id => quiz_questions(:one).id, :my_answer => quiz_questions(:one).correct_answer.body )
    assert_response :success
    assert_match( /\"explanation\": \"#{quiz_questions(:one).explanation}\"/,
      @response.body )
    assert_match( /\"correct_answer\": \"#{quiz_questions(:one).correct_answer.body}\"/,
      @response.body )

    assert_not_nil session[:answer_hash]
    assert_not_nil session[:answer_hash][@quiz_page.id]
    assert_not_nil session[:answer_hash][@quiz_page.id][quiz_questions(:one).id]
    assert_not_nil quiz_questions(:one).correct_answer_id
    assert_equal quiz_questions(:one).correct_answer_id, session[:answer_hash][@quiz_page.id][quiz_questions(:one).id]
  end
end
