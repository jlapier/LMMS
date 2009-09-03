require 'test_helper'

class QuizPagesControllerTest < ActionController::TestCase
  def setup
    @learning_module = LearningModule.find :first
    @section = @learning_module.sections.first
    @bulk_params = { :learning_module_id => @learning_module.id, :section_id => @section.id }
  end

  test "should get index" do
    get :index, @bulk_params
    assert_response :success
    assert_not_nil assigns(:quiz_pages)
  end

  test "should get new" do
    login_as(:quentin)
    get :new, @bulk_params
    assert_response :success
  end

  test "should create quiz_page" do
    login_as(:quentin)
    assert_difference('QuizPage.count') do
      post :create, @bulk_params.merge(:quiz_page => { :title => "SPPOFDSfsd" })
    end

    assert_redirected_to learning_module_section_quiz_page_path(@learning_module, @section, assigns(:quiz_page))
  end

  test "should show quiz_page" do
    get :show, @bulk_params.merge(:id => quiz_pages(:one).id)
    assert_response :success
  end

  test "should get edit" do
    login_as(:quentin)
    get :edit, @bulk_params.merge(:id => quiz_pages(:one).id)
    assert_response :success
  end

  test "should update quiz_page" do
    login_as(:quentin)
    put :update, @bulk_params.merge(:id => quiz_pages(:one).id, :quiz_page => { :title => "FSDFDSFDS" })
    assert_redirected_to learning_module_section_quiz_page_path(@learning_module, @section, assigns(:quiz_page))
  end

  test "should destroy quiz_page" do
    login_as(:quentin)
    assert_difference('QuizPage.count', -1) do
      delete :destroy, @bulk_params.merge(:id => quiz_pages(:one).id)
    end

    assert_redirected_to learning_module_section_quiz_pages_path(@learning_module, @section)
  end

  test "should redirect when get score and not enough answers" do
    get :score, @bulk_params.merge(:id => quiz_pages(:one).id)
    assert_redirected_to learning_module_section_quiz_page_path(@learning_module, @section, assigns(:quiz_page))
  end

  test "should get score when enough answers" do
    session[:answer_hash] = { quiz_pages(:one).id => {
        quiz_questions(:one).id => quiz_questions(:one).correct_answer_id,
        quiz_questions(:two).id => quiz_questions(:two).correct_answer_id
        }
      }
    get :score, @bulk_params.merge(:id => quiz_pages(:one).id)
    assert_response :success
    assert_template 'score'
    assert_not_nil assigns(:quiz_page)
    assert_equal 100, assigns(:score)
  end
end
