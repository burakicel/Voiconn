require 'test_helper'

class GameControllerTest < ActionController::TestCase
  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get inventory" do
    get :inventory
    assert_response :success
  end

  test "should get buy" do
    get :buy
    assert_response :success
  end

  test "should get sell" do
    get :sell
    assert_response :success
  end

  test "should get message" do
    get :message
    assert_response :success
  end

end
