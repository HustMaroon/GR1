class LearningsController < ApplicationController
	def index
		@learnings = Learning.all 
	end

	def update
		learning = Learning.find(params[:id])
		learning.update_attributes(learning_params)
		redirect_to request.referer
	end

	private
	def learning_params
		params.require(:learning).permit(:term_point)
	end
end
