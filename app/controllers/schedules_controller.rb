class SchedulesController < ApplicationController

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@schedules = @sclass.schedules.paginate(page: params[:page], per_page: 10)
	end

	def update_schedules
		params[:schedule].each do |k,v|
			schedule = Schedule.find(k)
			schedule.update_attributes(content: v)
		end
		redirect_to :back
	end

	def update
		@schedule = Schedule.find(params[:id])
		@schedule.update_attributes(content: params[:schedule][:content])
		@schedule.save
		respond_to do |format|
			format.html {redirect_to :back}
			format.js
		end
	end

	def show
		@schedule = Schedule.find(params[:id])
	end

	def date_time_table
		@date = params[:date].to_date
		@schedules = []
		current_user.schedules.each do |sc|
			@schedules << sc if sc.date == @date
		end
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
