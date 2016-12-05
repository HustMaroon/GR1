class LearningsController < ApplicationController
	def index
		@sclass = Sclass.find(params[:sclass_id])
		@learnings = @sclass.learnings
	end

	def update
		byebug
	end

	def create
		byebug
		learning = Learning.new(new_learning_params)
		if learning.save
			redirect_to request.referer
		end
	end
	private
	def new_learning_params
		params.require(:learning).permit(:student_id, :sclass_id)
	end
	def learning_params
		params.require(:learning).permit(:term_point, :process_point)
	end
end
