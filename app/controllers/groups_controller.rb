class GroupsController < ApplicationController
	before_action :logged_in_user
	before_action :login_as_teacher, only:[:new, :create, :destroy, :remove_member, :update_group_point]
	autocomplete :student, :name, :display_value => :name_and_id

	def new
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		group = sclass.groups.build(group_params)
		if group.save
			unless params[:group][:students].empty?
				params[:group][:students].each do |st|
					student = Student.find_by(std_id: st.split('-')[1]) unless st.empty?
					learning = Learning.find_by(sclass: sclass, student: student)
					learning.update_attributes(group: group) unless learning.nil?
				end
				new_group_assign_noti group				
			end
		else
			flash[:warning] = "Không thể tạo nhóm mới"
		end
		redirect_to :back
	end

	def index
		@sclass = Sclass.find(params[:sclass_id])
		if current_user.class == Student
			if current_user.groups.find_by(sclass_id: @sclass.id).nil?
				@groups = []
			else
				redirect_to sclass_group_path(@sclass, current_user.groups.find_by(sclass_id: @sclass.id))
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
		@group.add_member(@student) if !(@student.nil?)
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
		params.require(:group).permit(:name, :topic)
	end

end
