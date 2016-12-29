class PointsController < ApplicationController

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@learning = current_user.learnings.find_by(sclass_id: @sclass.id)
		@points = @learning.points
	end
end
