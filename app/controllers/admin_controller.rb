require 'roo'

class AdminController < ApplicationController
	before_action :login_as_admin, except:[:sign_in]

	def student_index
		@students = Student.search(params[:search]).paginate(page: params[:page], per_page: 10)
		@student = Student.new
	end

	def teacher_index
		@teachers = Teacher.search(params[:search]).paginate(page: params[:page], per_page: 10)
		@teacher = Teacher.new
	end

	def course_index
		@courses = Course.search(params[:search]).paginate(page: params[:page], per_page: 10)
		@course = Course.new
	end

	def class_index
		@classes = Sclass.search(params[:search]).paginate(page: params[:page], per_page: 10)
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
				course = Course.new(course_id: xlsx.row(i+2)[0], name: xlsx.row(i+2)[1], term_ratio: xlsx.row(i+2)[2])
				course.save
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
				course = Course.find_by(course_id: xlsx.row(i+2)[1])
				if course.nil?
					next
				else
					sclass = Sclass.find_by(sclass_id: xlsx.row(i+2)[0])
					teacher = Teacher.find_by(email: xlsx.row(i+2)[2])
					sclass = course.sclasses.create(sclass_id: xlsx.row(i+2)[0], teacher: teacher.nil? ? nil : Teacher.find_by(email: xlsx.row(i+2)[2]), room: xlsx.row(i+2)[3], 
													start_date: xlsx.row(i+2)[7], end_date: xlsx.row(i+2)[8]) if sclass.nil?
					#cretae new schedule
						sclass.make_schedules(xlsx.row(i+2)[4], xlsx.row(i+2)[5], xlsx.row(i+2)[6], xlsx.row(i+2)[7], xlsx.row(i+2)[8])
						sclass.score_components.create(content: 'Điểm nhóm', ratio: 0)
				end
			end
		end
		redirect_to admin_classes_path
	end

	def upload_students
		if params[:file].nil?
			flash[:waring] = 'bạn chưa chọn file'
		else
			xlsx = Roo::Spreadsheet.open(params[:file])
			byebug
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

	def change_password
		if request.method == "GET"

		elsif request.method == "POST"
			admin = current_user
			if admin.authenticate(params[:old_password]) && params[:new_password] == params[:new_password_confirmation]
				admin.update_attributes(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
				flash[:success] = "Cập nhật mật khẩu thành công!"
			else
				flash[:warning] = "Vui lòng kiểm tra lại!"
			end
			redirect_to admin_classes_path
		end			
	end

end
