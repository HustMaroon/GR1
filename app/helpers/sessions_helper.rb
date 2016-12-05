module SessionsHelper
	def log_in(user)
		if user.class == Teacher
    	session[:teacher_id] = user.id
    elsif user.class == Student
      session[:student_id] = user.id
    else
      session[:admin_id] = user.id
    end
  end

  def current_user
  	if session[:teacher_id]
    	@current_user ||= Teacher.find_by(id: session[:teacher_id])
    elsif session[:student_id]
    	@current_user ||= Student.find_by(id: session[:student_id])
    elsif session[:admin_id]
      @current_user ||= Admin.find_by(id: session[:admin_id])
    end
  end

	def logged_in?
  	!current_user.nil?
	end

	def log_out
		if session[:teacher_id]
  		session.delete(:teacher_id)
  	elsif session[:student_id]
  		session.delete(:student_id)
    else
      session.delete(:admin_id)
  	end 
  	@current_user = nil
	end
end
