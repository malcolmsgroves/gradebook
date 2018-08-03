class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_teacher, only: [:show]
  before_action :confirm_admin, only: [:admin_index]

  # a complete course listing that includes
  # enrollment and grade averages for each class
  def admin_index
    @courses = Course.course_listing
  end

  # index all the student's grades and course names
  def student_index
    @user = current_user
    @grades = Grade.where(student_id: @user.id).includes(:course)
    @gpa = @grades.average(:grade)
  end

  # index all a teachers courses
  def teacher_index
    @user = current_user
    @courses = User.find(@user.id).taught_courses # secures courses bc it uses current user
    @grade = Grade.new
  end

  # show the teacher the students with their grades
  # and let them manage the roster
  def show
    @course = Course.find(params[:id])
    @grades = @course.grades.includes(:student)
  end

  # root path for welcome and redirect
  def home
  end

  private

  # assert the user requesting the teacher index
  # page for a course is actually the instructor
  def confirm_teacher
    @user = current_user
    if !@user.taught_courses.where(id: params[:id]).exists?
      flash[:alert] = "You do not have access to this course since you are not the instructor"
      redirect_to root_path
    end
  end

  # assert the user is an administrator
  def confirm_admin
    @user = current_user
    if !@user.admin
      flash[:alert] = "You do not have access to this resource since you are not an administrator"
      redirect_to root_path
    end
  end
end
