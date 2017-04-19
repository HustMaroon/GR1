class TopicsController < ApplicationController
	before_action :login_as_teacher, only:[:new, :create, :destroy]
	protect_from_forgery :except => [:update]
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
		topic = Topic.find(params[:id])
		topic.update_attributes(topic_params)
		respond_to do |format|
			format.html {redirect_to request.referer}
			format.js {render 'update', locals: {id: "topic-"+topic.id.to_s+"-"+params[:topic][:updated_attr].to_s, value: topic.send(params[:topic][:updated_attr])}}
		end
	end

	def destroy
		topic = Topic.find(params[:id])
		topic.destroy
		redirect_to :back
	end

private
	def topic_params
		params.require(:topic).permit(:title, :ratio, :deadline)
	end
end
