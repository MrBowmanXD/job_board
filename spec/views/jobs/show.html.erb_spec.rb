require 'rails_helper'

RSpec.describe "jobs/show", type: :view do
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

    assign(:job, Job.create!(
      title: "Title",
      description: "MyText",
      company: "Company",
      location: "Location",
      user: user # Associate the job with the user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Company/)
    expect(rendered).to match(/Location/)
  end
end
