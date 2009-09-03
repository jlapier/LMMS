require 'test_helper'

class ContentPagesControllerTest < ActionController::TestCase
  def setup
    @learning_module = LearningModule.find :first
    @section = @learning_module.sections.first
    @bulk_params = { :learning_module_id => @learning_module.id, :section_id => @section.id }
  end

  test "should get index" do
    get :index, @bulk_params
    assert_redirected_to learning_module_section_path(@learning_module, @section)
  end

  test "should get new" do
    login_as(:quentin)
    get :new, @bulk_params
    assert_response :success
  end

  test "should create content_page" do
    login_as(:quentin)
    assert_difference('ContentPage.count') do
      post :create, @bulk_params.merge(:content_page => { :title => 'goof!', :main_body => "I'm required!" })
    end

    assert_redirected_to learning_module_section_content_page_path(@learning_module, @section, assigns(:content_page))
  end

  test "should show content_page" do
    get :show, @bulk_params.merge(:id => content_pages(:one).id)
    assert_response :success
  end

  test "should get edit" do
    login_as(:quentin)
    get :edit, @bulk_params.merge(:id => content_pages(:one).id)
    assert_response :success
  end

  test "should update content_page" do
    login_as(:quentin)
    put :update, @bulk_params.merge(:id => content_pages(:one).id, :content_page => { :title => 'soof!'} )
    assert_redirected_to learning_module_section_content_page_path(@learning_module, @section, assigns(:content_page))
  end

  test "should destroy content_page" do
    login_as(:quentin)
    assert_difference('ContentPage.count', -1) do
      delete :destroy, @bulk_params.merge(:id => content_pages(:one).id)
    end

    assert_redirected_to learning_module_section_path(@learning_module, @section)
  end
end
