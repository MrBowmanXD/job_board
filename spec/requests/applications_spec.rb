require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "POST /jobs/:job_id/applications" do
    let!(:user) { User.create(name: 'Jonh Doe', role: 'developer', email: "user@example.com", password: "password") }
    let!(:job) { Job.create(title: "Software Engineer", description: "Looking for a talented software engineer.", company: 'Continente', location: 'Amadora', application_date: Date.today) }
    let(:valid_attributes) {
      {
        applicant_information: "I have experience in web development.",
        resume_text: "My resume text here.",
        cover_letter: "My cover letter here.",
        application_status: "Pending",
        submitted_at: Date.today,
        user_id: user.id,
        job_id: job.id
      }
    }

    context "when the application is valid" do
      it "creates a new application" do
        expect {
          post job_applications_path(job), params: { application: valid_attributes }
        }.to change(Application, :count).by(1)

        expect(response).to redirect_to(job_path(job))
        expect(flash[:notice]).to eq("Application was successfully created.")
      end
    end

    context "when the application is invalid" do
      let(:invalid_attributes) {
        {
          applicant_information: "",
          resume_text: "My resume text here.",
          cover_letter: "My cover letter here.",
          application_status: "Pending",
          submitted_at: Date.today,
          user_id: user.id,
          job_id: job.id
        }
      }

      it "does not create a new application" do
        expect {
          post job_applications_path(job), params: { application: invalid_attributes }
        }.not_to change(Application, :count)

        expect(response).to have_http_status(422)
      end
    end
  end
end
