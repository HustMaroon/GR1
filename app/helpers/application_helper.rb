module ApplicationHelper

	def get_process_point(learning)
		0
	end

	def get_avg_point(learning)
		ratio = learning.sclass.subject.term_ratio
		avg = learning.term_point * ratio + get_process_point(learning) * (1- ratio)
		avg.round(2)
	end
end
