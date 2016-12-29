class GroupsController < ApplicationController
	before_action :login_as_teacher, only:[:new, :create, :destroy]

	def new
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		group = sclass.groups.build(group_params)
		if group.save
			params[:group][:students].each do |st|
				student = Student.find_by(std_id: st.split('-')[1]) unless st.empty?
				group.student_groups.create(student: student)
			end
		else
			flash[:warning] = "can't create new group"
		end
		redirect_to :back
	end

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@groups = @sclass.groups
		grouped_students = []
		@sclass.groups.each do |g|
			g.students.each do |s|
				grouped_students << s
			end
		end
		@students = @sclass.students - grouped_students
	end

	def show
		@sclass = Sclass.find(params[:sclass_id])
		@group = Group.find(params[:id])
		if current_user.class == Teacher
			render 'show'
		elsif current_user.class == Student
			render 'student_show'
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def remove_member
		sg = StudentGroup.find_by(student_id: params[:format], group_id: params[:group_id])
		sg.destroy unless sg.nil?
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
