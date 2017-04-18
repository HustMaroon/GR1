class TeachersController < ApplicationController
	before_action :login_as_admin, only: [:create, :destroy]
	before_action :login_as_teacher, only: [:update, :show]
	def destroy
		Teacher.find(params[:id]).destroy
		flash[:success] = "teacher removed"
		redirect_to request.referer
	end

	def create
		teacher = Teacher.new(teacher_params)
		if teacher.save
			flash.now[:success] = "teacher #{params[:teacher][:name]} added successfully!"
			redirect_to admin_teachers_path
		else
			flash.now[:danger] = "failed!"
			redirect_to admin_teachers_path
		end
	end

	def update
		@teacher = Teacher.find(params[:id])
		if @teacher.authenticate(params[:teacher][:old_password]) && params[:teacher][:password] == params[:teacher][:password_confirmation]
			@teacher.update_attributes(password: params[:teacher][:password], password_confirmation: params[:teacher][:password_confirmation])
			flash[:success] = "Cập nhật mật khẩu thành công!"
		else
			flash[:warning] = "Vui lòng kiểm tra lại!"
		end
		redirect_to teacher_path @teacher
	end

	def show
		@teacher = Teacher.find(params[:id])
	end

	private
	def teacher_params
		params.require(:teacher).permit(:name,:email)
	end
end
