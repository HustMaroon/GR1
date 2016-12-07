require 'roo'

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

	def upload_courses
		if params[:file].nil?
			flash[:waring] = "no file chosen"
		else
			xlsx = Roo::Spreadsheet.open(params[:file]) unless params[:file].nil?
			row_number = xlsx.last_row - xlsx.first_row + 1
			row_number.times do |i|
				Subject.create(sbj_id: xlsx.row(i+1)[0], name: xlsx.row(i+1)[1], term_ratio: xlsx.row(i+1)[2])
			end
		end
		redirect_to admin_courses_path
	end
end
