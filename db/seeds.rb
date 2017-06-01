# master_klass = [Student, Teacher, Sclass, course, Learning]
master_klass = [Student, Teacher, Sclass]

master_klass.each do |klass|
  klass.destroy_all
  puts "Deleted all #{klass} data"
end
# 10.times do |n|
#   name  = Faker::Name.name
#   email = "teacher#{n+1}@wow.com"
#   Teacher.create!(name:  name,
#               email: email,
#               password:              '123456',
#               password_confirmation: '123456'
#               )
# end

2500.times do |n|
  name  = Student.generate("male")
  std_id = "#{n+20122410}"
  # Student.create(name:  name,
  #             std_id: std_id,
  #             password:              '123456',
  #             password_confirmation: '123456'
  #             )
  time = Time.now.to_s(:db)
  sql = "INSERT INTO students (name, std_id, password_digest, created_at, updated_at) VALUES ('#{name}', '#{std_id}', '$2a$10$F5i/2cxu8EDHl5a5wwhPcONmr8gi2Y41mgyH8iTSOVIXSqrz6gtLy', '#{time}', '#{time}')"
  records_array = ActiveRecord::Base.connection.execute(sql)
  puts "created male student #{std_id} with name #{name}"
end

2500.times do |n|
  name  = Student.generate("female")
  std_id = "#{n+20132410}"
  # Student.create(name:  name,
  #             std_id: std_id,
  #             password:              '123456',
  #             password_confirmation: '123456'
  #             )
  time = Time.now.to_s(:db)
  sql = "INSERT INTO students (name, std_id, password_digest, created_at, updated_at) VALUES ('#{name}', '#{std_id}', '$2a$10$F5i/2cxu8EDHl5a5wwhPcONmr8gi2Y41mgyH8iTSOVIXSqrz6gtLy', '#{time}', '#{time}')"
  records_array = ActiveRecord::Base.connection.execute(sql)
  puts "created female student #{std_id} with name #{name}"
end



50.times do |n|
  name  = Teacher.generate("male")
  email = "teacher_#{n}@hust.edu.vn"
  Teacher.create(name:  name,
              email: email,
              password:              '123456',
              password_confirmation: '123456'
              )
  puts "created female teacher named #{name}"
end

50.times do |n|
  i = Teacher.count
  name  = Teacher.generate("female")
  email = "teacher_#{i}@hust.edu.vn"
  Teacher.create(name:  name,
              email: email,
              password:              '123456',
              password_confirmation: '123456'
              )
  puts "created female teacher named #{name}"
end
# course_hash = Hash["MathI" => "MI1012", "PhisicalI" => "PH1017",
#                     "Computer knowledge" => "IT2120",
#                     "C programing" => "IT3210", "Electrical engine" => "ET2111" ]
# course_hash.each do |k,v|
#     course.create(name: k, course_id: v)
#     puts "Created course #{k} with id #{v}"
# end

# course.all.each do |s|
#   rand(10).times do |n|
#     s.sclasses.create(teacher: Teacher.all[rand(10)],
#                       sclass_id: n)
#   end
# end

# MAX_STUDENTS_OF_CLASS = 40
# Sclass.all.each do |sc|
#   rand(MAX_STUDENTS_OF_CLASS).times do |n|
#     learning = sc.learnings.create(student: Student.all[rand(100)] )
#     puts "student #{learning.student.name} joined #{learning.sclass.sclass_id}"
#   end
# end


