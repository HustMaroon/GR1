class SchedulesController < ApplicationController

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@schedules = @sclass.schedules
		if current_user.class == Teacher
			render 'index'
		else
			render 'student_index'
		end
	end

	def update_schedules
		params[:schedule].each do |k,v|
			schedule = Schedule.find(k)
			schedule.update_attributes(content: v)
		end
		redirect_to :back
	end

	# def student_index
	# 	@sclass = Sclass.find(params[:sclass_id])
	# 	@schedules = []
	# 	current_user.sclasses.each do |sc|
	# 		sc.schedules.each do |sch|
	# 			@schedules << sch
	# 		end
	# 	end
	# end
end
