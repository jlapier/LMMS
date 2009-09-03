require 'test_helper'

class SectionsControllerTest < ActionController::TestCase
  def setup
    @learning_module = LearningModule.find :first
  end

  test "should redirect on get index" do
    get :index, :learning_module_id => @learning_module.id
    assert_redirected_to @learning_module
  end

  test "should get new" do
    login_as(:quentin)
    get :new, :learning_module_id => @learning_module.id
    assert_response :success
  end

  test "should create section" do
    login_as(:quentin)
    assert_difference('Section.count') do
      post :create, :learning_module_id => @learning_module.id, :section => { :title => "Boof" }
    end

    assert_redirected_to learning_module_section_path(assigns(:learning_module), assigns(:section))
  end

  test "should show section" do
    get :show, :learning_module_id => @learning_module.id, :id => sections(:one).id
    assert_response :success
  end

  test "should get edit" do
    login_as(:quentin)
    get :edit, :learning_module_id => @learning_module.id, :id => sections(:one).id
    assert_response :success
  end

  test "should update section" do
    login_as(:quentin)
    put :update, :learning_module_id => @learning_module.id, :id => sections(:one).id, :section => { :title => 'Boofy' }
    assert_redirected_to learning_module_section_path(assigns(:learning_module), assigns(:section))
  end

  test "should destroy section" do
    login_as(:quentin)
    assert_difference('Section.count', -1) do
      delete :destroy, :learning_module_id => @learning_module.id, :id => sections(:one).id
    end

    assert_redirected_to learning_module_path(assigns(:learning_module))
  end
end
