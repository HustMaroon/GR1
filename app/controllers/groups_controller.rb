class GroupsController < ApplicationController
	before_action :loggin_as_teacher, only:[:new, :create, :destroy]

	def new
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		group = sclass.groups.build(group_params)
		group.topic = Topic.find(params[:group][:topic])
		unless group.save
			flash[:warning] = "Error creating group"
		end
		redirect_to :back
	end

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@groups = @sclass.groups
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

private
	def group_params
		params.require(:group).permit(:name)
	end
end
