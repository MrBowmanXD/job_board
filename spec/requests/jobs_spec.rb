RSpec.describe "Jobs", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      get jobs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      job = Job.create(title: "Software Engineer", description: "Looking for a talented software engineer.")
      get job_path(job)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      job = Job.create(title: "Software Engineer", description: "Looking for a talented software engineer.")
      get edit_job_path(job)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new Job with valid parameters" do
      valid_attributes = {
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7
      }
      expect {
        post jobs_path, params: { job: valid_attributes }
      }.to change(Job, :count).by(1)
    end

    it "redirects to the created job with valid parameters" do
      valid_attributes = {
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7
      }
      post jobs_path, params: { job: valid_attributes }
      expect(response).to redirect_to(job_path(Job.last))
    end

    it "does not create a new Job with invalid parameters" do
      invalid_attributes = {
        title: nil,
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7
      }
      expect {
        post jobs_path, params: { job: invalid_attributes }
      }.not_to change(Job, :count)
    end

    it "renders a response with 422 status for invalid parameters" do
      invalid_attributes = {
        title: nil,
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7
      }
      post jobs_path, params: { job: invalid_attributes }
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH /update" do
    let!(:job) do
      Job.create(
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7
      )
    end

    it "updates the requested job with valid parameters" do
      updated_attributes = { title: "Updated Job Title" }
      patch job_path(job), params: { job: updated_attributes }
      expect(job.reload.title).to eq("Updated Job Title")
    end

    it "redirects to the job with valid parameters" do
      updated_attributes = { title: "Updated Job Title" }
      patch job_path(job), params: { job: updated_attributes }
      expect(response).to redirect_to(job_path(job))
    end

    it "renders a response with 422 status for invalid parameters" do
      invalid_attributes = { title: nil }
      patch job_path(job), params: { job: invalid_attributes }
      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /destroy" do
    let!(:job) do
      Job.create(
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        company: "Example Company",
        location: "New York",
        application_date: Date.today + 7
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
