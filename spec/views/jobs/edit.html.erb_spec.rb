require 'rails_helper'

RSpec.describe "jobs/edit", type: :view do
  let(:job) {
    Job.create!(
      title: "MyString",
      description: "MyText",
      company: "MyString",
      location: "MyString"
    )
  }

  before(:each) do
    assign(:job, job)
  end

  it "renders the edit job form" do
    render

    assert_select "form[action=?][method=?]", job_path(job), "post" do

      assert_select "input[name=?]", "job[title]"

      assert_select "textarea[name=?]", "job[description]"

      assert_select "input[name=?]", "job[company]"

      assert_select "input[name=?]", "job[location]"
    end
  end
end
