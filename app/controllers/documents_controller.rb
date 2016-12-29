class DocumentsController < ApplicationController

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
		doc = Document.find(parmam[:id])
		doc.destroy
		redirect_to :back
	end

	def index
		@sclass= Sclass.find(params[:sclass_id])
		@documents = @sclass.documents
		if current_user.class == Teacher
			render 'index'
		elsif current_user.class == Student
			render 'student_index'
		end 
	end
private
	def doc_params
		params.require(:document).permit(:title, :description, :file)
	end
end
