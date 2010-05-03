require 'test_helper'

class AbstractTestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abstract_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abstract_test" do
    assert_difference('AbstractTest.count') do
      post :create, :abstract_test => { }
    end

    assert_redirected_to abstract_test_path(assigns(:abstract_test))
  end

  test "should show abstract_test" do
    get :show, :id => abstract_tests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => abstract_tests(:one).to_param
    assert_response :success
  end

  test "should update abstract_test" do
    put :update, :id => abstract_tests(:one).to_param, :abstract_test => { }
    assert_redirected_to abstract_test_path(assigns(:abstract_test))
  end

  test "should destroy abstract_test" do
    assert_difference('AbstractTest.count', -1) do
      delete :destroy, :id => abstract_tests(:one).to_param
    end

    assert_redirected_to abstract_tests_path
  end
end
