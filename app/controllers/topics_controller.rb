class TopicsController < ApplicationController
	before_action :login_as_teacher, only:[:new, :create, :destroy]

	def new
	end

	def create
		sclass = Sclass.find(params[:sclass_id])
		topic = sclass.topics.build(topic_params)
		unless topic.save
			flash[:warning] = "Không thể thêm chủ đề mới"
		end
		redirect_to :back
	end

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@topics = @sclass.topics.paginate(page: params[:page], per_page: 10)
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
		params.require(:topic).permit(:title, :ratio, :deadline)
	end
end
