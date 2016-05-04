class AdminController < ApplicationController
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
end
