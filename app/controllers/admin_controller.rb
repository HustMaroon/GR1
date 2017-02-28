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
			row_number = xlsx.last_row - xlsx.first_row
			row_number.times do |i|
				subject = Subject.new(sbj_id: xlsx.row(i+2)[0], name: xlsx.row(i+2)[1], term_ratio: xlsx.row(i+2)[2])
				subject.save
			end
		end
		redirect_to admin_courses_path
	end

	def upload_sclasses
		if params[:file].nil?
			flash[:waring] = 'no file chosen'
		else
			xlsx = Roo::Spreadsheet.open(params[:file])
			row_number = xlsx.last_row - xlsx.first_row
			row_number.times do |i|
				#create new sclass
				course = Subject.find_by(sbj_id: xlsx.row(i+2)[1])
				sclass = course.sclasses.build(sclass_id: xlsx.row(i+2)[0], teacher: Teacher.find(xlsx.row(i+2)[2]), room: xlsx.row(i+2)[3], 
												start_date: xlsx.row(i+2)[7], end_date: xlsx.row(i+2)[8]) unless course.nil?
				if !(sclass.nil?) && sclass.save
				#cretae new schedule
				sclass.make_schedules(xlsx.row(i+2)[4], xlsx.row(i+2)[5], xlsx.row(i+2)[6], xlsx.row(i+2)[7], xlsx.row(i+2)[8])
				sclass.point_components.create(content: 'Điểm nhóm', ratio: 0)
				end
			end
		end
		redirect_to admin_classes_path
	end

	def upload_students
		if params[:file].nil?
			flash[:waring] = 'no file chosen'
		else
			xlsx = Roo::Spreadsheet.open(params[:file])
			row_number = xlsx.last_row - xlsx.first_row + 1
			row_number.times do |i|
				student = Student.new(std_id: xlsx.row(i+1)[0], name: xlsx.row(i+1)[1], password: '123456', password_confirmation: '123456')
				student.save
			end
		end
		redirect_to admin_students_path
	end

	def upload_teachers
		if params[:file].nil?
			flash[:warning] = 'no file chosen'
		else
			xlsx = Roo::Spreadsheet.open(params[:file])
			row_number = xlsx.last_row - xlsx.first_row
			row_number.times do |i|
				teacher = Teacher.new(name: xlsx.row(i+2)[0], email: xlsx.row(i+2)[1], password: '123456', password_confirmation: '123456')
				teacher.save
			end
		end
		redirect_to admin_teachers_path
	end

end
