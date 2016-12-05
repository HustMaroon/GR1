class AdminController < ApplicationController
	before_action :login_as_admin, only:[:student_index, :teacher_index, :course_index, :class_index]

	def student_index
		@students = Student.search(params[:search])
		@student = Student.new
	end

	def teacher_index
		@teachers = Teacher.search(params[:search])
		@teacher = Teacher.new
	end

	def course_index
		@subjects = Subject.search(params[:search])
		@subject = Subject.new
	end

	def class_index
		@classes = Sclass.search(params[:search])
		@sclass = Sclass.new
	end

	def sign_in
	end
end
