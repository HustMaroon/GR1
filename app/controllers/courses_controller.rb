class CoursesController < ApplicationController
	before_action :loggin_as_admin
	def destroy
		course.find(params[:id]).destroy
		flash[:success] = "course removed"
		redirect_to request.referer
	end

	def create
		course = course.new(course_params)
		if course.save
			flash[:success] = "course #{params[:course][:course_id]} created successfully!"
			redirect_to admin_courses_path
		else
			flash[:warning] = "failed!"
			redirect_to admin_courses_path
		end
	end

	private
	def course_params
		params.require(:course).permit(:course_id, :name)
	end
end
