require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "admin scope" do
    get root_path
    assert_response :redirect
    
    @user = users(:admin)
    sign_in(@user)
    get root_path
    assert_response :success
    
    get admin_index_path
    assert_response :success
    
    get student_index_path
    assert_response :success

    @course = courses(:spanish)
    get course_path(@course)
    assert_response :redirect
  end

  test "teacher scope" do
    @user = users(:teacher)
    sign_in @user

    get admin_index_path
    assert_response :redirect

    get student_index_path
    assert_response :success

    @course = courses(:spanish)
    get course_path(@course)
    assert_response :success
  end

  test "student scope" do
    @user = users(:student)
    sign_in @user

    get admin_index_path
    assert_response :redirect

    @course = courses(:spanish)
    get course_path(@course)
    assert_response :redirect
  end
end
