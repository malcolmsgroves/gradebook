class GradesController < ApplicationController
  before_action :authenticate_user!
  
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

end
