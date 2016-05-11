class StaticPagesController < ApplicationController
	def home
		if current_user.class == Student
			@asm_num = current_user.mini_works.count
		end
	end
end
