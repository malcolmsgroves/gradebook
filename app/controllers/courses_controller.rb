class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_teacher, only: [:show]
  before_action :confirm_admin, only: [:admin_index]
  
  def admin_index
    @courses = Course.all
                 .joins(:grades)
                 .group(:id)
                 .pluck(:name,
                        Arel.sql('count(grades.id)'),
                        Arel.sql('avg(grades.grade)'))
  end

  def student_index
    @user = current_user
    @grades = Grade.where(student_id: @user.id).includes(:course)
    @gpa = @grades.average(:grade)
  end

  def teacher_index
    @user = current_user
    @courses = User.find(@user.id).taught_courses # secures courses bc it uses current user
    @grade = Grade.new
  end

  def show
    @course = Course.find(params[:id])
    @grades = @course.grades.includes(:student)
  end

  def home
  end

  private

  def confirm_teacher
    @user = current_user
    if !@user.taught_courses.where(id: params[:id]).exists?
      flash[:alert] = "You do not have access to this course since you are not the instructor"
      redirect_to root_path
    end
  end

  def confirm_admin
    @user = current_user
    if !@user.admin
      flash[:alert] = "You do not have access to this resource since you are not an administrator"
      redirect_to root_path
    end
  end
end
