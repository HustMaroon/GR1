class SubjectsController < ApplicationController
	def destroy
		Subject.find(params[:id]).destroy
		flash[:success] = "course removed"
		redirect_to request.referer
	end

	def create
		subject = Subject.new(subject_params)
		if subject.save
			flash[:success] = "course #{params[:subject][:sbj_id]} created successfully!"
			redirect_to admin_courses_path
		else
			flash[:warning] = "failed!"
			redirect_to admin_courses_path
		end
	end

	private
	def subject_params
		params.require(:subject).permit(:sbj_id, :name)
	end
end
