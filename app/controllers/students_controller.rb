class StudentsController < ApplicationController
	def destroy
		Student.find(params[:id]).destroy
		flash[:success] = "student removed"
		redirect_to request.referer
	end

	def new
		@student = Student.new
	end

	def create
		student = Student.new(student_params)
		if student.save
			flash.now[:success] = "student #{params[:student][:name]} added successfully!"
			redirect_to admin_students_path
		else
			flash.now[:danger] = "failed!"
			redirect_to admin_students_path
		end
	end

	private
	def student_params
		params.require(:student).permit(:name,:std_id)
	end

end
