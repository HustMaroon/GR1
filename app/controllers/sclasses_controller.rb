class SclassesController < ApplicationController
	before_action :ratio_validate, only:[:update_ratio]
	before_action :logged_in_user
	before_action :login_as_admin, only: [:destroy, :create, :edit]
	
	def destroy
		Sclass.find(params[:id]).destroy
		flash[:success] = "đã xóa lớp học!"
		redirect_to request.referer
	end

	def create
		sclass = Sclass.new(sclass_params)
		if sclass.save
			flash.now[:success] = "class #{params[:sclass][:sclass_id]} created successfully!"
			redirect_to admin_classes_path
		else
			flash.now[:danger] = "failed!"
			redirect_to admin_classes_path
		end
	end

	def index
		@sclasses = current_user.sclasses.opening_classes
	end

	def edit
		@sclass = Sclass.find(params[:id])
	end

	def update
		sclass = Sclass.find(params[:id])
		course = Course.find_by(course_id: params[:sclass][:course])
		teacher = Teacher.find_by(email: params[:sclass][:teacher])
		if course.nil? || teacher.nil?
			redirect_to edit_sclass_path(sclass)
			flash[:warning] == "update thất bại, vui lòng kiểm tra lại email hoặc mã học phần"
		else
			sclass.update_attributes(sclass_id: params[:sclass][:sclass_id], course: course, teacher: teacher, 
															room: params[:sclass][:room], start_date: params[:sclass][:start_date],
															end_date: params[:sclass][:end_date])
			flash[:success] = "Cập nhật lớp thành công!"
			redirect_to admin_classes_path
		end
	end

	def show
		@sclass = Sclass.find(params[:id])
		if @sclass.get_learned_lessons == 0 || @sclass.students.count == 0
			@attendant_scale = 0
		else
			@attendant_scale = 100 - @sclass.missed_logs.count / (@sclass.get_learned_lessons * @sclass.students.count.to_f) * 100 
		end
		@received_reports = @sclass.get_received_reports
		@total_reports = @sclass.topics.count * @sclass.groups.count
		@lessons_in_percentage = @sclass.get_learned_lessons / @sclass.schedules.count.to_f * 100
		if current_user.class == Student
			@missed_lessons_in_percentage = current_user.get_missed_lessons(@sclass) / @sclass.schedules.count.to_f * 100
		end
	end

	def student_index
		@classes = Sclass.search(params[:search])
		@sclass = Sclass.new
		@learning = Learning.new
	end

	def rollup
		@sclass = Sclass.find(params[:sclass_id])
		@students = @sclass.students
	end

	def process_rollup
		sclass = Sclass.find(params[:sclass_id])
		params.each do |pr|
			if pr[1] == "attend"
			student = Student.find(pr[0])
			learning = Learning.find_by(student_id: student.id, sclass_id: sclass.id)
			learning.attendance += 1
			learning.save
			end
		end
		redirect_to :back
	end

	def update_ratio
		params[:pc].each do |k,v|
			pc = ScoreComponent.find(k)
			pc.update_attributes(content: v[:content], ratio: v[:ratio])
		end
		redirect_to :back
	end

	def update_avg_point
		params[:term_point].each do |k,v|
			learning = Learning.find(k)
			learning.update_attributes(term_point: v)
			learning.save
			new_point_update_noti learning.student, learning.sclass
		end
		redirect_to :back
	end

	def update_student_list
		if params[:file].nil?
			flash[:waring] = 'bạn chưa chọn file'
		else
			if params[:file].content_type != 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
				flash[:warning] = 'vui lòng tải lên định dạng excel'
			else
				@sclass = Sclass.find(params[:sclass_id])
				xlsx = Roo::Spreadsheet.open(params[:file])
				row_number = xlsx.last_row - xlsx.first_row + 1
				row_number.times do |i|
					student = Student.find_by(std_id: xlsx.row(i+2)[1])
					student = Student.create(std_id: xlsx.row(i+2)[1], name: xlsx.row(i+2)[0], password: '123456', password_confirmation: '123456') if student.nil?
					learning = @sclass.learnings.create(student: student) if student.learnings.where(sclass: @sclass).empty?
				end
				flash[:success] = 'cập nhật danh sách sinh viên thành công'
			end
		end
		redirect_to :back
	end

	private
	def sclass_params
		params.require(:sclass).permit(:course_id,:teacher_id, :sclass_id)
	end

	def ratio_validate
		sclass = Sclass.find(params[:sclass_id])
		unless caculate_ratio_sum(params) <= 100
			flash[:warning] = "tổng các chỉ tiêu không được > 100%"
			redirect_to :back
		end
	end

	def caculate_ratio_sum(params)
		sum = 0
		params[:pc].each do |k,v|
			sum += v[:ratio].to_i
		end
		return sum
	end
end
