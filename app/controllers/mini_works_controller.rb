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
			redirect_to request.referer
		else
			redirect_to request.referer
		end
	end

	def index
		@mini_works = MiniWork.all
		@mini_work = MiniWork.new
		@ratios = (1..100).select{|a| a%5 ==0}
		@sclasses = Sclass.all
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

	def student_index
		@mini_works = current_user.mini_works
	end

	def destroy
		mini_work = MiniWork.find(params[:id])
		mini_work.destroy
		respond_to do |format|
			format.html do
				redirect_to '/mini_works'
			end
		end
	end

	def test_submit
		byebug
		correct_answer =0
		total = 0

	end

	private
	def mini_work_params
		params.require(:mini_work).permit(:sclass_id, :name, :ratio, :content, :deadline)
	end
end
