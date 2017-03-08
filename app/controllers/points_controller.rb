class PointsController < ApplicationController
	before_action :logged_in_user
	def index
		@sclass = Sclass.find(params[:sclass_id])
		@learning = current_user.learnings.find_by(sclass_id: @sclass.id)
		@points = @learning.points
	end
end
