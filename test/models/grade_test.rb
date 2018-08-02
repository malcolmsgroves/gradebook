require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "requires grade value" do
    grade = Grade.new
    course = Course.create!(name: "Math", teacher_id: 1)
    assert_not grade.save
    grade.student_id = 2
    grade.course_id = 2
    grade.grade = 40
    assert_not grade.save # students can only enroll once
    grade.course_id = course.id
    assert grade.save!
    grade.grade = -10
    assert_not grade.save
    grade.grade = 110
    assert_not grade.save
  end

  test "gives relationship between user and courses" do
    teacher = User.create!(email: 'teach@email.com', password: 'password',
                       password_confirmation: 'password',
                       first_name: "Mr.",
                       last_name: "West")
    course = teacher.taught_courses.create!(name: "Math")
    grade = course.grades.build(grade: 3.3, student_id: 2)
    student = User.find(2)
    assert_equal(student.courses.count, 2) # see tests/fixtures/grades.yml
    assert grade.save!
    assert_equal(student.courses.count, 3)
  end
end
