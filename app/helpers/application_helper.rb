module ApplicationHelper

	def get_process_point(learning)
		process_point = 0
		learning.points.each do |p|
			process_point += (p.value * p.score_table.point_component.ratio) /100
		end
		return process_point
	end

	def get_avg_point(learning)
		ratio = learning.sclass.subject.term_ratio
		avg = learning.term_point * ratio + get_process_point(learning) * (1- ratio)
		avg.round(2)
	end

	def get_ratio_sum(sclass)
		sum = 0
		sclass.point_components.each do |pc|
			sum += pc.ratio
		end
		return sum
	end
end
