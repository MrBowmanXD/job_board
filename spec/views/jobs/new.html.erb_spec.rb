require 'rails_helper'

RSpec.describe "jobs/new", type: :view do
  before(:each) do
    assign(:job, Job.new(
      title: "MyString",
      description: "MyText",
      company: "MyString",
      location: "MyString"
    ))
  end

  it "renders new job form" do
    render

    assert_select "form[action=?][method=?]", jobs_path, "post" do

      assert_select "input[name=?]", "job[title]"

      assert_select "textarea[name=?]", "job[description]"

      assert_select "input[name=?]", "job[company]"

      assert_select "input[name=?]", "job[location]"
    end
  end
end
