class SchedulesController < ApplicationController

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@schedules = @sclass.schedules
	end

	def update_schedules
		params[:schedule].each do |k,v|
			schedule = Schedule.find(k)
			schedule.update_attributes(content: v)
		end
		redirect_to :back
	end
end
