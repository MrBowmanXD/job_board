require 'rails_helper'

RSpec.describe Application, type: :model do
  let(:user) { User.create(name: "John Doe", email: "john.doe@example.com", password: "password") }
  let(:job) { Job.create(title: "Software Engineer", description: "Looking for a talented software engineer.") }

  describe "validations" do
    it "is valid with valid attributes" do
      application = Application.new(
        user: user,
        job: job,
        applicant_information: "Applicant information",
        resume_text: "Resume content",
        cover_letter: "Cover letter content",
        application_status: "Submitted",
        submitted_at: Date.today
      )
      expect(application).to be_valid
    end

    it "is not valid without a user" do
      application = Application.new(
        job: job,
        applicant_information: "Applicant information",
        resume_text: "Resume content",
        cover_letter: "Cover letter content",
        application_status: "Submitted",
        submitted_at: Date.today
      )
      expect(application).not_to be_valid
    end

    it "is not valid without a job" do
      application = Application.new(
        user: user,
        applicant_information: "Applicant information",
        resume_text: "Resume content",
        cover_letter: "Cover letter content",
        application_status: "Submitted",
        submitted_at: Date.today
      )
      expect(application).not_to be_valid
    end

    it "is not valid without applicant_information" do
      application = Application.new(
        user: user,
        job: job,
        resume_text: "Resume content",
        cover_letter: "Cover letter content",
        application_status: "Submitted",
        submitted_at: Date.today
      )
      expect(application).not_to be_valid
    end

    it "is not valid without resume_text" do
      application = Application.new(
        user: user,
        job: job,
        applicant_information: "Applicant information",
        cover_letter: "Cover letter content",
        application_status: "Submitted",
        submitted_at: Date.today
      )
      expect(application).not_to be_valid
    end

    it "is not valid without cover_letter" do
      application = Application.new(
        user: user,
        job: job,
        applicant_information: "Applicant information",
        resume_text: "Resume content",
        application_status: "Submitted",
        submitted_at: Date.today
      )
      expect(application).not_to be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      application = Application.new(
        user: user,
        job: job,
        applicant_information: "Applicant information",
        resume_text: "Resume content",
        cover_letter: "Cover letter content",
        application_status: "Submitted",
        submitted_at: Date.today
      )
      expect(application.user).to eq(user)
    end

    it "belongs to a job" do
      application = Application.new(
        user: user,
        job: job,
        applicant_information: "Applicant information",
        resume_text: "Resume content",
        cover_letter: "Cover letter content",
        application_status: "Submitted",
        submitted_at: Date.today
      )
      expect(application.job).to eq(job)
    end
  end
end
