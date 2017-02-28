class StudentsController < ApplicationController
	def destroy
		Student.find(params[:id]).destroy
		flash[:success] = "student removed"
		redirect_to request.referer
	end

	def new
		@student = Student.new
	end

	def create
		student = Student.new(student_params)
		if student.save
			flash.now[:success] = "student #{params[:student][:name]} added successfully!"
			redirect_to admin_students_path
		else
			flash.now[:danger] = "failed!"
			redirect_to admin_students_path
		end
	end

	def show
		@student = Student.find(params[:id])
	end

	def update
		@student = Student.find(params[:id])
		if @student.authenticate(params[:student][:old_password]) && params[:student][:password] == params[:student][:password_confirmation]
			@student.update_attributes(password: params[:student][:password], password_confirmation: params[:student][:password_confirmation])
			flash[:success] = "Cập nhật mật khẩu thành công!"
		else
			flash[:warning] = "Vui lòng kiểm tra lại!"
		end
		redirect_to student_path @student
	end

	private
	def student_params
		params.require(:student).permit(:name,:std_id)
	end

end
