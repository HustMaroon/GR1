class LearningsController < ApplicationController
	def index
		@sclasses = current_user.sclasses
		if params[:sclass].nil?
			@sclass = current_user.sclasses.first
		else
			@sclass = current_user.sclasses.find(params[:sclass][:id])
		end
		@learnings = @sclass.learnings
	end

	def update
		learning = Learning.find(params[:id])
		learning.update_attributes(learning_params)
		avg_point = learning.process_point*0.3 + learning.term_point*0.7
		learning.update_attributes(avg_point: avg_point)
		redirect_to request.referer
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
