class RollupController < ApplicationController
	before_action :login_as_teacher
	def new
		@sclass = Sclass.find(params[:sclass_id])
		@schedule = Schedule.find(params[:schedule_id])
		@students = @sclass.students.all
		# respond_to do |format|
		# 	format.html
		# 	format.json {render json: @student}
		# end
	end

	def logging
		sclass = Sclass.find(params[:sclass_id])
		schedule = Schedule.find(params[:schedule_id])
		schedule.missed_logs.destroy_all
		params[:missed].each do |k,v|
			student = Student.find(k)
			MissedLog.create(student: student, schedule: schedule) if (schedule != nil && student != nil)
		end
		redirect_to sclass_schedule_missed_logs_path(sclass, schedule)
	end
end
