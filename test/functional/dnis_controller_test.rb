require 'test_helper'

class DnisControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dnis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dni" do
    assert_difference('Dni.count') do
      post :create, :dni => { }
    end

    assert_redirected_to dni_path(assigns(:dni))
  end

  test "should show dni" do
    get :show, :id => dnis(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => dnis(:one).to_param
    assert_response :success
  end

  test "should update dni" do
    put :update, :id => dnis(:one).to_param, :dni => { }
    assert_redirected_to dni_path(assigns(:dni))
  end

  test "should destroy dni" do
    assert_difference('Dni.count', -1) do
      delete :destroy, :id => dnis(:one).to_param
    end

    assert_redirected_to dnis_path
  end
end
