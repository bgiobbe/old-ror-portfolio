require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get concour" do
    get :concour
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get interests" do
    get :interests
    assert_response :success
  end

  test "should get resume" do
    get :resume
    assert_response :success
  end

  test "should get vision" do
    get :vision
    assert_response :success
  end

end
