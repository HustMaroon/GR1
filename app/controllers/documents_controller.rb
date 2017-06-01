class DocumentsController < ApplicationController
	before_action :logged_in_user
	before_action :login_as_teacher, only: [:create, :destroy]

	def create
		sclass = Sclass.find(params[:sclass_id])
		doc = sclass.documents.build(doc_params)
		if doc.save
			redirect_to :back
		else
			flash[:warning] = "failed to upload file"
			redirect_to :back
		end
	end

	def destroy
		doc = Document.find(params[:id])
		doc.destroy
		redirect_to :back
	end

	def index
		@sclass= Sclass.find(params[:sclass_id])
		@documents = @sclass.documents
	end
private
	def doc_params
		params.require(:document).permit(:title, :description, :file)
	end
end
