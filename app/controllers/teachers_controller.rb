class TeachersController < ApplicationController
	def destroy
		Teacher.find(params[:id]).destroy
		flash[:success] = "teacher removed"
		redirect_to request.referer
	end

	def create
		teacher = Teacher.new(sclass_params)
		if teacher.save
			flash.now[:success] = "teacher #{params[:teacher][:name]} added successfully!"
			redirect_to admin_teachers_path
		else
			flash.now[:danger] = "failed!"
			redirect_to admin_teachers_path
		end
	end

	private
	def sclass_params
		params.require(:teacher).permit(:name,:email)
	end
end
