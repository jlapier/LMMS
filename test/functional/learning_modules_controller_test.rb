require 'test_helper'

class LearningModulesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:learning_modules)
  end

  test "should get new" do
    login_as(:quentin)
    get :new
    assert_response :success
  end

  test "should create learning_module" do
    login_as(:quentin)
    assert_difference('LearningModule.count') do
      post :create, :learning_module => { :title => 'toof!' }
    end

    assert_redirected_to learning_module_path(assigns(:learning_module))
  end

  test "should show learning_module" do
    get :show, :id => learning_modules(:one).id
    assert_response :success
  end

  test "should get edit" do
    login_as(:quentin)
    get :edit, :id => learning_modules(:one).id
    assert_response :success
  end

  test "should update learning_module" do
    login_as(:quentin)
    put :update, :id => learning_modules(:one).id, :learning_module => { :title => 'sooof!' }
    assert_redirected_to learning_module_path(assigns(:learning_module))
  end

  test "should destroy learning_module" do
    login_as(:quentin)
    assert_difference('LearningModule.count', -1) do
      delete :destroy, :id => learning_modules(:one).id
    end

    assert_redirected_to learning_modules_path
  end
end
