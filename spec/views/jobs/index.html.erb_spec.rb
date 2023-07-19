require 'rails_helper'

RSpec.describe "jobs/index", type: :view do
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

    assign(:jobs, [
      Job.create!(
        title: "Title",
        description: "MyText",
        company: "Company",
        location: "Location",
        user: user # Associate the job with the user
      ),
      Job.create!(
        title: "Title",
        description: "MyText",
        company: "Company",
        location: "Location",
        user: user # Associate the job with the user
      )
    ])
  end

  it "renders a list of jobs" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Company".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Location".to_s), count: 2
  end
end
