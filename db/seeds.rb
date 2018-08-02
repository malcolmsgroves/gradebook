# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(0...5).each do |x|
  teacher = User.create!(
    email: "teacher#{x}@school.edu",
    password: "password",
    password_confirmation: 'password',
    first_name: Faker::Name.first_name(),
    last_name: Faker::Name.last_name())
  (0...4).each do |y|
    teacher.taught_courses.create!(
      name: Faker::Book.title())
  end
end

all_courses = Course.all

(0...50).each do |x|
  student = User.create!(
    email: "student#{x}@school.edu",
    password: "password",
    password_confirmation: "password",
    first_name: Faker::Name.first_name(),
    last_name: Faker::Name.last_name())
  
  courses = all_courses.sample(5)
  courses.each do |course|
    grade = Grade.create!(
      grade: Faker::Number.between(0, 100),
      course_id: course.id,
      student_id: student.id)
  end
end
