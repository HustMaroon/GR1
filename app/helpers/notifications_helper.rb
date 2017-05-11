module NotificationsHelper
	include ApplicationHelper
	def new_report_noti teacher, group
		Notification.create(user_id: teacher.id, user_type: 1, link: sclass_group_path(group.sclass, group),
												content: "#{group.name}, lớp #{group.sclass.sclass_id}-#{group.sclass.name} đã nộp báo cáo.")
	end

	def new_reminder user 
		if user.get_schedules(Date.tomorrow).count >0 && (user.last_reminded.nil? || user.last_reminded < Date.today)
			if user.class == Teacher
				user_type = 1
			elsif user.class == Student
				user_type = 2
				user.groups.each do |g|
					g.sclass.topics.each do |t|
						if t.days_to_deadline < 3 && !isReported?(g, t)
							Notification.create(user_id: user.id, user_type: user_type, link: sclass_group_path(g.sclass, g),
																	content: "Nhắc nhở: thời hạn nộp bài còn #{t.days_to_deadline} ngày")
						end
					end
				end
			end
			Notification.create(user_id: user.id, user_type: user_type, link: "/date_time_table/#{Date.tomorrow}",
													content: "Bạn có #{user.get_schedules(Date.tomorrow).count} giờ lên lớp ngày mai")
			user.update_attributes(last_reminded: Date.today)
		end
	end

	def new_group_assign_noti group
		group.students.each do |st| 
			Notification.create(user_id: st.id, user_type: 2, link: sclass_group_path(group.sclass, group),
												content: "Bạn đã được thêm vào group #{group.name}")
		end
	end

	# def new_deadline_remind_noti student, group
	# 	if group.days_to_deadline <= 5 && group.report.nil? 
	# 		Notification.create(user_id: student.id, user_type: 2, link: "sclasses/#{group.sclass.id}/groups/#{group.id}",
	# 											content: "Nhắc nhở: thời hạn nộp bài còn #{group.days_to_deadline} ngày")
	# 	end
	# end

	def new_point_update_noti student, sclass
		Notification.create(user_id: student.id, user_type: 2, link: sclass_points_path(sclass),
												content: "Điểm môn #{sclass.course.name} đã được cập nhật")
	end

	def new_class_missed_noti student, schedule
		Notification.create(user_id: student.id, user_type: 2, link: "#{Rails.application.config.root_path}/date_time_table/#{schedule.date}",
												content: "Bạn đã vắng mặt lớp #{schedule.sclass.course.name} vào ngày schedule.date")
	end

	# def check_for_notifications user
	# 		new_lessons_remind_noti user
	# 	if user.class == Student
	# 		user.groups.each do |g|
	# 			new_deadline_remind_noti user, g
	# 		end
	# 	end
	# end
end
