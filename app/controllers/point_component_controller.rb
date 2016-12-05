class PointComponentController < ApplicationController
	before_action :sum_validate, only:[:create]

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@point_component = @sclass.point_component.nil? ? @sclass.build_point_component : @sclass.point_component
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		pc = sclass.build_point_component( mid_term_test: params[:mid_term_test], short_test: params[:short_test], 
																	apperance: params[:apperance])
		if pc.save
			flash[:success] = 'cập nhật trọng số thành công'
		else
			flash[:warning] = 'cập nhật trọng số thất bại'
		end
		redirect_to :back
	end

	def update
		byebug
	end
private

	def sum_validate
		unless params[:mid_term_test].to_i + params[:short_test].to_i + params[:apperance].to_i == 100
			flash[:warning] = 'tổng các chỉ tiêu phải là 100'
			redirect_to :back
		end
	end
end
