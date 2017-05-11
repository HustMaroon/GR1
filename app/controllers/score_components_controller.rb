include ApplicationHelper
class ScoreComponentsController < ApplicationController
	# before_action :sum_validate, only:[:create]
	before_action :ratio_validate, only:[:create]
	before_action :login_as_teacher

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@score_components = @sclass.score_components.all
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		pc = sclass.score_components.build( pc_params )
		if pc.save
			flash[:success] = 'cập nhật trọng số thành công'
		else
			flash[:warning] = 'cập nhật trọng số thất bại'
		end
		redirect_to :back
	end

	def destroy
		score_component = PointComponent.find(params[:id])
		score_component.destroy
		redirect_to :back
	end
private

	def sum_validate
		unless params[:mid_term_test].to_i + params[:short_test].to_i + params[:apperance].to_i == 100
			flash[:warning] = 'tổng các chỉ tiêu phải là 100'
			redirect_to :back
		end
	end

	def ratio_validate
		sclass = Sclass.find(params[:sclass_id])
		unless get_ratio_sum(sclass) + params[:score_component][:ratio].to_i <= 100
			flash[:warning] = "tổng các chỉ tiêu không được > 100%"
			redirect_to :back
		end
	end

	def pc_params
		params.require(:score_component).permit(:content, :ratio)
	end
end
