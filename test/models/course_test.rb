require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "requires course name and teacher" do
    teacher = User.create!(email: 'teach@email.com', password: 'password',
                       password_confirmation: 'password',
                       first_name: "Mr.",
                       last_name: "West")
    course = teacher.taught_courses.build
    assert_not course.save
    course.name = "Math"
    assert course.save!
    assert_equal(teacher.taught_courses.count, 1)
  end

  test "course listing" do
    @courses = Course.course_listing
    assert_equal(@courses[0][1], 1)
    assert_equal(@courses[1][1], 1)
  end
end
