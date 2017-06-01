class GroupsController < ApplicationController
	before_action :logged_in_user
	before_action :login_as_teacher, only:[:new, :create, :destroy, :remove_member, :update_group_point]

	def new
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		group = sclass.groups.build(group_params)
		if group.save
			student_arr = params[:group][:students].split(',')
			student_arr.pop
			student_arr.each do |student|
				student_id = student.delete(' ').split('-')[1] #get student id
				student = Student.find_by(std_id: student_id)
				unless student.nil?
					learning = sclass.learnings.find_by(student: student)
					group.add_member(learning)
				end
			end
			flash[:success] = "Tạo nhóm thành công"
			redirect_to sclass_group_path(sclass, group)
		else
			flash[:warning] = "Không thể tạo nhóm mới"
			redirect_to :back
		end
	end

	def index
		@sclass = Sclass.find(params[:sclass_id])
		if current_user.class == Student
			learning = Learning.find_by(sclass: @sclass, student: current_user)
			if learning.group.nil?
				@groups = []
			else
				redirect_to sclass_group_path(@sclass, learning.group)
			end
		else
			@groups = @sclass.groups
			@students = @sclass.ungrouped_students
		end
	end

	def show
		@sclass = Sclass.find(params[:sclass_id])
		@group = Group.find(params[:id])
		@topics = @sclass.topics
		if current_user.class == Teacher
			@ungrouped_students = @sclass.ungrouped_students
		elsif current_user.class == Student
			render 'student_show', toics: @topics
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def add_member
		@sclass = Sclass.find(params[:sclass_id])
		@group = Group.find(params[:group_id])
		@student = Student.find_by(std_id: params[:student_name].split('-')[1])
		learning = @sclass.learnings.find_by(student: @student)
		@group.add_member(learning) unless learning.nil?
		respond_to do |format|
			format.html{redirect_to :back}
			format.js
		end
	end

	def remove_member
		sclass = Sclass.find(params[:sclass_id])
		student = Student.find(params[:format])
		learning = Learning.find_by(sclass: sclass, student: student)
		learning.update_attributes(group: nil)
		redirect_to :back
	end

	def update_group_point
		group = Group.find(params[:group_id])
		group.update_attributes(point: params[:point]) unless group.nil?
		redirect_to :back
	end

	def upload_report
		group = Group.find(params[:group_id])
		group.update_attributes(report: params[:group][:report])
		group.save
		redirect_to :back
	end

private
	def group_params
		params.require(:group).permit(:name, :sclass_id)
	end

end
