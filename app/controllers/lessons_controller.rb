class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_lesson, only: [:update]
  before_action :enrolled_in_course?, only: [:show]

  def show
  end

	private

	def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      redirect_to courses_path, alert: 'You must be enrolled in a course to view its lessons.'
    end
  end

  def enrolled_in_course?
    if !current_user.enrolled_in?(current_lesson.section.course) 
      if current_lesson.section.course.user != current_user
        redirect_to courses_path, alert: 'You must be enrolled in a course to view its lessons.'
      end
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
