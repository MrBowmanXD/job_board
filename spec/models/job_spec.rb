require 'rails_helper'

RSpec.describe Job, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      job = Job.new(title: "Software Engineer", description: "Looking for a talented software engineer.")
      expect(job).to be_valid
    end

    it "is not valid without a title" do
      job = Job.new(title: nil, description: "Looking for a talented software engineer.")
      expect(job).not_to be_valid
    end

    it "is not valid without a description" do
      job = Job.new(title: "Software Engineer", description: nil)
      expect(job).not_to be_valid
    end

    # Add more validation tests as per your Job model's validation rules
  end

  # Add any other custom model logic tests as needed
end

