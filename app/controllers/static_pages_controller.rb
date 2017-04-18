class StaticPagesController < ApplicationController
	include NotificationsHelper
	def home
		if !(current_user.nil?)
			new_reminder current_user
			@schedules = []
			current_user.sclasses.each do |sc|
				@schedules += sc.schedules
			end
		end
	end
end
