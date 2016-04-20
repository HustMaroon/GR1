class MiniWorksController < ApplicationController
	def new
		@mini_work = MiniWork.new
		@ratios = (1..100).select{|a| a%5 ==0}
		@sclasses = Sclass.all
	end

	def create
		mini_work = MiniWork.new(mini_work_params)
		if mini_work.save
			flash.now[:success] = "Successfully created miniwork"
			redirect_to '/mini_works'
		else
			render 'new'
		end
	end

	def index
		@mini_works = MiniWork.all
	end

	def edit
		@ratios = (1..100).select{|a| a%5 ==0}
		@sclasses = Sclass.all
		@mini_work = MiniWork.find(params[:id])
	end

	def update
		mini_work = MiniWork.find(params[:id])
		mini_work.update_attributes(mini_work_params)
		if mini_work.save
			flash.now[:success] = "mini work editted!"
			redirect_to '/mini_works'
		else
			flash.now[:danger] = "unable to update mini work"
			redirect_to '/mini_works'
		end
	end

	private
	def mini_work_params
		params.require(:mini_work).permit(:sclass_id, :name, :ratio)
	end
end
