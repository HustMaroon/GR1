class SessionsController < ApplicationController
  def new
  end

  def create
  	if params[:session][:email]
	    teacher = Teacher.find_by(email: params[:session][:email].downcase)
	    if teacher && teacher.authenticate(params[:session][:password])
	      log_in teacher
	      redirect_to '/rollup'
	    else
	      flash[:danger] = 'Invalid email/password combination'
	      redirect_to request.referer
	    end
	elsif params[:session][:std_id]
		student = Student.find_by(std_id: params[:session][:std_id])
	    if student && student.authenticate(params[:session][:password])
	      log_in student
	      redirect_to root_url
	    else
	      flash[:danger] = 'Invalid email/password combination'
	      redirect_to request.referer
	    end
	end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
