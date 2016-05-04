class SclassesController < ApplicationController
	def destroy
		Sclass.find(params[:id]).destroy
		flash[:success] = "class removed"
		redirect_to request.referer
	end

	def create
		sclass = Sclass.new(sclass_params)
		if sclass.save
			flash.now[:success] = "class #{params[:sclass][:sclass_id]} created successfully!"
			redirect_to admin_classes_path
		else
			flash.now[:danger] = "failed!"
			redirect_to admin_classes_path
		end
	end

	private
	def sclass_params
		params.require(:sclass).permit(:subject_id,:teacher_id, :sclass_id)
	end
end
