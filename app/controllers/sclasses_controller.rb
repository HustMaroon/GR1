class SclassesController < ApplicationController
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
		@sclasses = current_user.sclasses
	end

	def show
		@sclass = Sclass.find(params[:id])
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

	def update_point
		params[:term_point].each do |k,v|
			learning = Learning.find(k)
			learning.update_attributes(term_point: v)
		end
		redirect_to :back
	end

	private
	def sclass_params
		params.require(:sclass).permit(:subject_id,:teacher_id, :sclass_id)
	end
end
