class MissedLogsController < ApplicationController
	before_action :login_as_teacher

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@schedule = Schedule.find(params[:schedule_id])
		@missed_logs = @schedule.missed_logs.search(params[:search]).paginate(page: params[:page], per_page: 10)
	end

	def class_index
		@sclass = Sclass.find(params[:sclass_id])
		@missed_logs = @sclass.missed_logs.search(params[:search]).paginate(page: params[:page], per_page: 10)
	end
end
