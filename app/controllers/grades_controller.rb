class GradesController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_correct_teacher, only: [:destroy, :edit, :update]
  before_action :confirm_teacher, only: [:create]
  def create
    @grade = Grade.new(student_id: params[:student_id], course_id: params[:course_id], grade: 100)
    if @grade.save!
      redirect_to course_path(@grade.course)
    else
      flash.now[:error] = @grade.errors.full_messages.to_sentence
    end
  end

  def destroy
    @id = params[:id]
    Grade.find(@id).destroy
    flash.now[:success] = "Student removed from course"
    respond_to do |format|
      format.js
    end
  end

  def edit
    @grade = Grade.find(params[:id])
    @course = @grade.course
    @student = @grade.student
  end

  def update
    @grade = Grade.find(params[:id])
    if @grade.update_attributes(grade: params[:grade])
      redirect_to course_path(@grade.course)
    else
      render 'edit'
    end
  end

  private
  def confirm_correct_teacher
    @grade = Grade.find(params[:id])
    @user = current_user
    if(@user.id != @grade.course.teacher.id)
      flash[:alert] = "You are not the teacher for the course"
      redirect_to root_path
    end
  end

  def confirm_teacher
    @user = current_user
    if(!current_user.teacher)
      flash[:alert] = "You are not the teacher for the course"
      redirect_to root_path
    end
  end
end
