class RollupController < ApplicationController
	def new
		@sclasses = Sclass.all
		if params[:sclass].nil?
			@sclass = Sclass.first
		else
			@sclass = Sclass.find(params[:sclass][:id])
		end
		@students = @sclass.students.all
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
		render 'done_rollup'
	end
end
