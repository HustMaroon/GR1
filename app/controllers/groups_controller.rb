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
	end

	def edit
	end

	def update
	end

	def destroy
	end

private
	def group_params
		params.require(:group).permit(:name, :topic)
	end

end
