class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  private
  def logged_in_user
  	unless logged_in?
  		redirect_to root_path
  		flash[:danger] = "Please log in first"
  	end
  end

  def loggin_as_teacher
  	unless current_user.class == Teacher
  		redirect_to :back
  		flash[:danger] = "You don't have permission to access this"
  	end
  end

  def loggin_as_student
  	unless current_user.class == Student
			redirect_to :back
			flash[:danger] = "You don't have permission to access this"
  	end
  end

  def login_as_admin
    unless current_user.class == Admin
      redirect_to admin_sign_in_path
      flash[:danger] = "You don't have permission to access this"
    end
  end
end
