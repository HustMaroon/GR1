class RollupController < ApplicationController
	def new
		@sclasses = current_user.sclasses
		if params[:sclass].nil?
			@sclass = @sclasses.first
		else
			@sclass = @sclasses.find(params[:sclass][:id])
		end
		@students = @sclass.students.all
		respond_to do |format|
			format.html
			format.json {render json: @student}
		end
	end

	def checklist
		sclass = Sclass.find(params[:class_id])
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
end
