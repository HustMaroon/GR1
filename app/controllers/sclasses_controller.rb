class SclassesController < ApplicationController
	before_action :ratio_validate, only:[:update_ratio]
	def destroy
		Sclass.find(params[:id]).destroy
		flash[:success] = "class removed"
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

	def show
		@sclass = Sclass.find(params[:id])
		@lessons_in_percentage = @sclass.get_remaining_lessons / @sclass.schedules.count.to_f * 100
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
			pc = PointComponent.find(k)
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

	private
	def sclass_params
		params.require(:sclass).permit(:subject_id,:teacher_id, :sclass_id)
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
