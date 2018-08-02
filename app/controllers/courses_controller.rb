class CoursesController < ApplicationController
  def admin_index
    @courses = Course.all
                 .joins(:grades)
                 .group(:id)
                 .pluck(:name,
                        'count(grades.id)',
                        'avg(grades.grade)')
  end

  def student_index
    @courses = Grades.find_by(student_id: params[:id]).includes(:course)
  end

  def teacher_index
    @courses = User.find(params[:id]).taught_courses
  end

  def show
    puts "here"
    @course = Course.find(params[:id])
    @grades = @course.grades.includes(:student)
  end
end
