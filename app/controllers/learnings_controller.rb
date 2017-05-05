class LearningsController < ApplicationController
	before_action :logged_in_user
	def index
		@sclass = Sclass.find(params[:sclass_id])
		@learnings = @sclass.learnings
		respond_to do |format|
			format.html
			format.xls
		end
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

	def destroy
		learning = Learning.find(params[:id])
		learning.destroy
		redirect_to :back
	end
	private
	def new_learning_params
		params.require(:learning).permit(:student_id, :sclass_id)
	end
	def learning_params
		params.require(:learning).permit(:term_point, :process_point)
	end
end
