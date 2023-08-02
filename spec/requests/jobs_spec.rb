require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  let(:user) do
    User.create!(
      name: "John Doe",
      email: "john.doe@example.com",
      password: "password",
      password_confirmation: "password",
      role: "job seeker"
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

    it "returns http success for a job seeker with less than five job postings" do
      # Create four job postings for the user
      4.times { |n| Job.create!(title: "Job #{n}", description: "Description", company: "Company", location: "Location", application_date: Date.today, user: user) }

      # Sign in the job seeker
      sign_in user

      # Try to access the index page
      get "/jobs"

      # Expect the response to have http status success
      expect(response).to have_http_status(:success)
    end

    it "returns http success for an anonymous user" do
      # Try to access the index page without signing in
      get jobs_path

      # Expect the response to have http status success
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "redirects to the home page with an unauthorized status for a job seeker with more than five job postings" do
      # Sign in the job seeker
      sign_in user

      # Create six job postings for the user
      6.times { |n| Job.create!(title: "Job #{n}", description: "Description", company: "Company", location: "Location", application_date: Date.today, user: user) }

      # Try to access the new job page using a get request
      get new_job_path

      # Expect the response to redirect to the home page with an unauthorized status (302)
      expect(response).to have_http_status(:unauthorized)
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
      sign_in user
      user.role = 'job poster'
      get edit_job_path(job)
      expect(response).to have_http_status(:success)
    end

    it "redirects to the home page with an unauthorized status for a job seeker with more than five job postings" do
      # Sign in the job seeker
      sign_in user

      # Create six job postings for the user
      6.times { |n| Job.create!(title: "Job #{n}", description: "Description", company: "Company", location: "Location", application_date: Date.today, user: user) }

      # Create a new job posting
      job = Job.create(title: "Software Engineer", description: "Looking for a talented software engineer.", company: "Example Company", location: "New York", application_date: Date.today + 7, user: user)

      # Try to access the edit job page using a get request
      get edit_job_path(job)

      # Expect the response to redirect to the home page with an unauthorized status (302)
      expect(response).to have_http_status(:unauthorized)
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
        user.role = 'job poster'
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

      it "redirects to the home page with an unauthorized status for a job seeker with more than five job postings" do
        # Sign in the job seeker
        sign_in user

        # Create six job postings for the user
        6.times { |n| Job.create!(title: "Job #{n}", description: "Description", company: "Company", location: "Location", application_date: Date.today, user: user) }

        # Try to create a new job posting using a post request
        post jobs_path, params: { job: { title: "New Job", description: "Description", company: "Company", location: "Location", application_date: Date.today } }

        # Expect the response to redirect to the home page with an unauthorized status (302)
        expect(response).to have_http_status(:unauthorized)
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

  describe "PATCH #update" do
    it "redirects to the home page with an unauthorized status for a job seeker with more than five job postings" do
      # Sign in the job seeker
      sign_in user

      # Create six job postings for the user
      6.times { |n| Job.create!(title: "Job #{n}", description: "Description", company: "Company", location: "Location", application_date: Date.today, user: user) }

      # Create a new job posting
      job = Job.create(title: "Software Engineer", description: "Looking for a talented software engineer.", company: "Example Company", location: "New York", application_date: Date.today + 7, user: user)

      # Try to update the job using a patch request
      patch job_path(job), params: { job: { title: "Updated Job Title" } }

      # Expect the response to redirect to the home page with an unauthorized status (302)
      expect(response).to have_http_status(:unauthorized)
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
      sign_in user
      user.role = 'job poster'
      expect {
        delete job_path(job)
      }.to change(Job, :count).by(-1)
    end

    it "redirects to the jobs list" do
      sign_in user
      user.role = 'job poster'
      delete job_path(job)
      expect(response).to redirect_to(jobs_path)
    end
  end
end
