# master_klass = [Student, Teacher, Sclass, Subject, Learning]

# master_klass.each do |klass|
#   klass.destroy_all
#   puts "Deleted all #{klass} data"
# end
# 10.times do |n|
#   name  = Faker::Name.name
#   email = "teacher#{n+1}@wow.com"
#   Teacher.create!(name:  name,
#               email: email,
#               password:              '123456',
#               password_confirmation: '123456'
#               )
# end

50.times do |n|
  name  = Student.generate("male")
  std_id = "#{n+20122410}"
  Student.new(name:  name,
              std_id: std_id,
              password:              '123456',
              password_confirmation: '123456'
              ).save
  puts "created male student #{std_id} with name #{name}"
end

50.times do |n|
  name  = Student.generate("female")
  std_id = "#{n+20122610}"
  Student.new(name:  name,
              std_id: std_id,
              password:              '123456',
              password_confirmation: '123456'
              ).save
  puts "created female student #{std_id} with name #{name}"
end

# subject_hash = Hash["MathI" => "MI1012", "PhisicalI" => "PH1017",
#                     "Computer knowledge" => "IT2120",
#                     "C programing" => "IT3210", "Electrical engine" => "ET2111" ]
# subject_hash.each do |k,v|
#     Subject.create(name: k, sbj_id: v)
#     puts "Created subject #{k} with id #{v}"
# end

# Subject.all.each do |s|
#   rand(10).times do |n|
#     s.sclasses.create(teacher: Teacher.all[rand(10)],
#                       sclass_id: n)
#   end
# end

MAX_STUDENTS_OF_CLASS = 40
Sclass.all.each do |sc|
  rand(MAX_STUDENTS_OF_CLASS).times do |n|
    sc.learnings.create(student: Student.all[rand(200)] )
  end
end