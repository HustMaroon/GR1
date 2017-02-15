class StaticPagesController < ApplicationController
	def home
		if current_user.class == Student
			@asm_num = current_user.mini_works.count
		end
		if current_user.class == Teacher
			@schedules = []
			current_user.sclasses.each do |sc|
				@schedules += sc.schedules
			end
		end
	end
end
