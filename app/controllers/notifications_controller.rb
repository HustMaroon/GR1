class NotificationsController < ApplicationController
	before_action :logged_in_user

	def index
		@notifications = current_user.notifications.paginate(page: params[:page], per_page: 10)
	end
end
