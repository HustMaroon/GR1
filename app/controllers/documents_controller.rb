class DocumentsController < ApplicationController

	def create
		sclass = Sclass.find_by(params[:sclass_id])
		doc = sclass.documents.build(doc_params)
		if doc.save
			redirect_to :back
		else
			flash[:warning] = "failed to upload file"
			redirect_to :back
		end
	end

	def destroy
		doc = Document.find(parmam[:id])
		doc.destroy
		redirect_to :back
	end

	def index
		@sclasses = current_user.sclasses
		if params[:sclass_id].nil?
			@sclass = @sclasses.first
		else
			@sclass = Sclass.find(params[:sclass_id])
		end
		@documents = @sclass.documents
	end
private
	def doc_params
		params.require(:document).permit(:title, :description, :file)
	end
end
