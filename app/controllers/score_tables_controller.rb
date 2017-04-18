class ScoreTablesController < ApplicationController
	before_action :login_as_teacher

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@score_tables = @sclass.score_tables
		@point_components = @sclass.point_components - @sclass.point_components.where(content: 'Điểm nhóm')
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
		score_table = ScoreTable.find(params[:id])
		id = score_table.id
		score_table.destroy
		respond_to do |format|
			format.html {redirect_to :back}
			format.js{render "destroy", :locals => {:id => id}}
		end
	end

	def update_score_table
		params[:point].each do |k,v|
			point = Point.find(k)
			point.update_attributes(value: v[:val], note: v[:note])
			new_point_update_noti point.learning.student, point.learning.sclass
		end
		redirect_to :back
	end
end
