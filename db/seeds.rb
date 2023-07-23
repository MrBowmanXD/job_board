# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

100.times do
	user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password, role: Faker::Job.field)
	job = Job.create(title: Faker::Job.title, description: Faker::Lorem.paragraph, company: Faker::Company.name, location: Faker::Address.city, application_date: Faker::Date.in_date_period, user_id: user.id)
	Application.create(applicant_information: Faker::Lorem.paragraph, resume_text: Faker::Lorem.paragraph, cover_letter: Faker::Lorem.paragraph, application_status: 'Evaluating', submitted_at: Date.today, user_id: user.id, job_id: job.id)
end

puts "Created #{Job.count} jobs" 
puts "Created #{User.count} users" 
puts "Created #{Application.count} applications" 