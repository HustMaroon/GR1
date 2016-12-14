class ScoreTablesController < ApplicationController
	before_action :login_as_teacher

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@score_tables = @sclass.score_tables
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		score_table = sclass.score_tables.build(title: params[:score_table][:title],
																						point_component: PointComponent.find(
																							params[:score_table][:point_component]))
		if score_table.save
			sclass.learnings.each do |l|
				point = score_table.points.build(learning: l)
				point.save
			end
			redirect_to :back
		else
			flash[:warning] = "Không thể tạo bảng điểm"
			redirect_to :back
		end
	end

	def show
		@sclass= Sclass.find(params[:sclass_id])
		@score_table = ScoreTable.find(params[:id])
	end

	def destroy
	end

	def update_score_table
		byebug
	end
end
