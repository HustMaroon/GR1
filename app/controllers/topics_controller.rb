class TopicsController < ApplicationController
	before_action :loggin_as_teacher, only:[:new, :create, :destroy]

	def new
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		topic = sclass.topics.build(topic_params)
		unless topic.save
			flash[:warning] = "Error creating topic"
		end
		redirect_to :back
	end

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@topics = @sclass.topics
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
	def topic_params
		params.require(:topic).permit(:name, :content )
	end
end
