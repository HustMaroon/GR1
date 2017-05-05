class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include NotificationsHelper
  protect_from_forgery with: :exception
  include SessionsHelper
  private
  def logged_in_user
  	unless logged_in?
  		redirect_to root_path
  		flash[:danger] = "Vui lòng đăng nhập"
  	end
  end

  def login_as_teacher
  	unless current_user.class == Teacher
  		redirect_to :back
  		flash[:danger] = "Bạn không có quyền truy nhập trang này"
  	end
  end

  def login_as_student
  	unless current_user.class == Student
			redirect_to :back
			flash[:danger] = "Bạn không có quyền truy nhập trang này"
  	end
  end

  def login_as_admin
    unless current_user.class == Admin
      redirect_to admin_sign_in_path
      flash[:danger] = "Bạn không có quyền truy nhập trang này"
    end
  end

  def login_as_admin_or_teacher
    unless (current_user.class == Admin || current_user.class == Teacher)
      redirect_to root_path
      flash[:denager] = "Bạn không có quyền truy nhập trang này"
    end
  end
end
