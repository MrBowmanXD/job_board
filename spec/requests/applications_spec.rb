require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "POST /jobs/:job_id/applications" do
    let(:valid_attributes) {
      {
        applicant_information: "I have experience in web development.",
        resume_text: "My resume text here.",
        cover_letter: "My cover letter here.",
      }
    }

    context "when the application is valid" do
      it "creates a new application" do
        user = User.create(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password, role: 'job seeker')
        sign_in user
        job = Job.create(title: Faker::Job.title, description: Faker::Lorem.paragraph, company: Faker::Company.name, location: Faker::Address.city, application_date: Faker::Date.in_date_period, user_id: user.id)
        expect {
          post job_applications_path(job_id: job.id, controller: :applications, action: :create), params: { application: valid_attributes }
        }.to change{Application.count}.by(1)

        expect(response).to redirect_to(job_path(job))
      end
    end

    context "when the application is invalid" do
      let(:invalid_attributes) {
        {
          applicant_information: "",
          resume_text: "My resume text here.",
          cover_letter: "My cover letter here.",
        }
      }

      it "does not create a new application" do
        user = User.new(name: Faker::Name.name, role: 'job seeker', email: "user@example.com", password: "password")
        user.save
        sign_in user
        job = Job.create(title: "Software Engineer", description: "Looking for a talented software engineer.", company: 'Continente', location: 'Amadora', application_date: Date.today, user_id: user.id)
        expect {
          post job_applications_path(job), params: { application: invalid_attributes }
        }.not_to change(Application, :count)

        # expect(response).to have_http_status(422)
      end
    end
  end
end
