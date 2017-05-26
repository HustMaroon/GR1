module ApplicationHelper
	MORNING_CLASSES_START_TIME = "6:45"
	AFTERNOON_CLASSES_START_TIME = "12:30"

	def get_process_point(learning)
		group = learning.group
		group_pc = learning.sclass.score_components.find_by(content: 'Điểm nhóm')
		group_ratio = group_pc.nil? ? 0 : group_pc.ratio
		process_point = group.nil? ? 0 : group.group_score * group_ratio /100
		learning.points.each do |p|
			freq = get_freq p
			process_point += (p.value * p.score_table.score_component.ratio/freq) /100
		end
		return process_point
	end

	def get_freq point
		freq = 0
		point.score_table.score_component.score_tables.count
	end

	def get_avg_point(learning)
		ratio = learning.sclass.course.term_ratio
		avg = learning.term_point * ratio + get_process_point(learning) * (1- ratio)
		avg.round(2)
	end

	def get_ratio_sum(sclass)
		sum = 0
		sclass.score_components.each do |pc|
			sum += pc.ratio
		end
		return sum
	end

	def get_topic_ratio_sum(sclass)
		sum = 0
		sclass.topics.each do |topic|
			sum += topic.ratio
		end
		return sum
	end

	def start_lesson_to_time(lesson)
		if lesson <= 6
			return (Time.parse(MORNING_CLASSES_START_TIME) + (lesson -1)*55*60).to_formatted_s(:time)
		else
			return (Time.parse(AFTERNOON_CLASSES_START_TIME) + (lesson -7)*55*60).to_formatted_s(:time)
		end
	end

	def end_lesson_to_time(lesson)
		if lesson <= 6
			return (Time.parse(MORNING_CLASSES_START_TIME) + lesson*55*60).to_formatted_s(:time)
		else
			return (Time.parse(AFTERNOON_CLASSES_START_TIME) + (lesson-6)*55*60).to_formatted_s(:time)
		end
	end

	def routed_from_noti?
		unless params[:noti_id].nil?
			noti = Notification.find(params[:noti_id])
			noti.update_attributes(read: true)
		end
	end

	def isReported?(group, topic)
		return Report.find_by(group: group, topic: topic).nil? ? false : true
	end
end
