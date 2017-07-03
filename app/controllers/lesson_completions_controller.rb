class LessonCompletionsController < ApplicationController
  before_action :authenticate_request
  before_action :lookup_lesson

  def create
    new_lesson_completion.save
  end

  def destroy
    lesson_completion.destroy
    render :create
  end

  private

  def lesson_completion
    current_user.lesson_completions.find(params[:id])
  end

  def new_lesson_completion
    LessonCompletion.new(student_id: current_user.id, lesson_id: @lesson.id)
  end

  def lookup_lesson
    @lesson = Lesson.friendly.find(params[:lesson_id])
  end

  def authenticate_request
    head :unauthorized unless user_signed_in?
  end
end
