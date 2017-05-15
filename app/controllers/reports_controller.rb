class ReportsController < ApplicationController
	def create
		topic = Topic.find(params[:topic_id])
		report = topic.reports.build(report_params)
		if report.save
			flash[:success] = "Đã tải lên báo cáo thành công"
		else
			flash[:warning] = "Tải lên báo cáo thất bại"
		end
		redirect_to request.referer
	end

	def update
		@report = Report.find(params[:id])
		if current_user.class == Student
			@report.update_attributes(report_params)		
			redirect_to request.referer
		else
			@report.update_attributes(teacher_report_params)
			respond_to do |format|
				format.html{redirect_to :back}
				format.js
			end
		end
	end

	private
	def report_params
		params.require(:report).permit(:group_id, :file)
	end

	def teacher_report_params
		params.require(:report).permit(:score)
	end
end
