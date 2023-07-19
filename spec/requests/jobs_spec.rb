require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  let(:user) do
    User.create!(
      name: "John Doe",
      email: "john.doe@example.com",
      password: "password",
      password_confirmation: "password",
      role: "job_seeker"
    )
  end

  before(:each) do
    sign_in user # Sign in the user using Devise test helper
  end

  describe "GET /index" do
    it "renders a successful response" do
      get jobs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:job) do
      Job.create(
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7,
        user: user # Associate the job with the user
      )
    end

    it "renders a successful response" do
      get job_path(job)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    let(:job) do
      Job.create(
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7,
        user: user # Associate the job with the user
      )
    end

    it "renders a successful response" do
      get edit_job_path(job)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) do
      {
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        company: "Example Company 2",
        location: "New York",
        application_date: Date.today + 7,
        user_id: user.id # Include the user_id to associate the job with the user
      }
    end

    context "when authenticated" do
      before(:each) do
        sign_in user
      end

      it "creates a new Job with valid parameters" do
        expect {
          post jobs_path, params: { job: valid_attributes }
        }.to change(Job, :count).by(1)

        # Ensure the job is associated with the user
        job = Job.last
        expect(job).to be_present
        expect(job.user).to eq(user)

        # Print any errors on the job instance, if present
        puts job.errors.full_messages if job.errors.any?
      end

      # ... Other tests ...
    end

    context "when not authenticated" do

      before(:each) do
        # Clear the session to simulate an unauthenticated user
        # This will effectively "log out" the user
        sign_out :user
      end

      it "does not create a new Job" do
        expect {
          post jobs_path, params: { job: valid_attributes }
        }.not_to change(Job, :count)
      end

      it "redirects to the sign-in page" do
        post jobs_path, params: { job: valid_attributes }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe "DELETE /destroy" do
    let!(:job) do
      Job.create(
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7,
        user: user # Associate the job with the user
      )
    end

    it "destroys the requested job" do
      expect {
        delete job_path(job)
      }.to change(Job, :count).by(-1)
    end

    it "redirects to the jobs list" do
      delete job_path(job)
      expect(response).to redirect_to(jobs_path)
    end
  end
end
