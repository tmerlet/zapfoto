require 'test_helper'

class RollsControllerTest < ActionController::TestCase
  setup do
    @roll = rolls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rolls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create roll" do
    assert_difference('Roll.count') do
      post :create, roll: { current: @roll.current, name: @roll.name, size: @roll.size, state: @roll.state, user_id: @roll.user_id }
    end

    assert_redirected_to roll_path(assigns(:roll))
  end

  test "should show roll" do
    get :show, id: @roll
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @roll
    assert_response :success
  end

  test "should update roll" do
    patch :update, id: @roll, roll: { current: @roll.current, name: @roll.name, size: @roll.size, state: @roll.state, user_id: @roll.user_id }
    assert_redirected_to roll_path(assigns(:roll))
  end

  test "should destroy roll" do
    assert_difference('Roll.count', -1) do
      delete :destroy, id: @roll
    end

    assert_redirected_to rolls_path
  end
end
