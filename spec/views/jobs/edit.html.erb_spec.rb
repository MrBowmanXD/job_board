require 'rails_helper'

RSpec.describe "jobs/edit", type: :view do
  let(:user) do
    User.create!(
      name: "John Doe",
      email: "john.doe@example.com",
      password: "password",
      password_confirmation: "password",
      role: "job_seeker"
    )
  end

  let(:job) do
    user.jobs.create!(
      title: "Software Engineer",
      description: "Looking for a talented software engineer.",
      company: "Example Company",
      location: "New York"
    )
  end

  before(:each) do
    sign_in user # Sign in the user using Devise test helper
    assign(:job, job) # Assign the 'job' instance to the view variable '@job'
  end

  it "renders the edit job form" do
    render

    assert_select "form[action=?][method=?]", job_path(job), "post" do
      assert_select "input[name=?]", "job[title]"
      assert_select "textarea[name=?]", "job[description]"
      assert_select "input[name=?]", "job[company]" # Ensure 'company' input field is present
      assert_select "input[name=?]", "job[location]" # Ensure 'location' input field is present
    end
  end
end
