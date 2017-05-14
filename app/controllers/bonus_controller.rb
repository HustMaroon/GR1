class BonusController < ApplicationController
	before_action :login_as_teacher

	def index
		@sclass = Sclass.find(params[:sclass_id])
		@bonus = @sclass.bonus
		@bonu = Bonu.new
	end

	def create
		@sclass = Sclass.find(params[:sclass_id])
		@bonu = @sclass.bonus.build(condition: params[:bonu][:condition], bonus: params[:bonu][:bonus])
		if @bonu.save
			respond_to do |format|
				format.html {redirect_to sclass_bonus_path(@sclass)}
				format.js
			end
		else
			flash.now[:danger] = "Không thể thêm điều kiện, vui lòng kiểm tra lại"
			redirect_to request.referer
		end
	end

	def destroy
		bonu = Bonu.find(params[:id])
		@id = bonu.id
		bonu.destroy
		respond_to do |format|
			format.html {redirect_to :back}
			format.js
		end
	end 
end
