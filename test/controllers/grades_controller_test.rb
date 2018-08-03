require 'test_helper'

class GradesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "student cannot change grades" do
    @user = users(:student)
    sign_in @user

    post grades_path
    assert_response :redirect

    @grade = grades(:one)
    get edit_grade_path(@grade)
    assert_response :redirect
  end

  test "teacher can change grades" do
    @user = users(:teacher)
    sign_in @user

    @grade = grades(:one)
    get edit_grade_path(@grade)
    assert_response :success
  end
end
