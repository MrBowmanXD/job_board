require 'rails_helper'

RSpec.describe Job, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      job = Job.new(
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        user: User.new(
          name: "John Doe",
          email: "john.doe@example.com",
          password: "password",
          password_confirmation: "password",
          role: "job_seeker"
        )
      )
      expect(job).to be_valid
    end

    it "is not valid without a title" do
      job = Job.new(
        title: nil,
        description: "Looking for a talented software engineer.",
        user: User.new(
          name: "John Doe",
          email: "john.doe@example.com",
          password: "password",
          password_confirmation: "password",
          role: "job_seeker"
        )
      )
      expect(job).not_to be_valid
    end

    it "is not valid without a description" do
      job = Job.new(
        title: "Software Engineer",
        description: nil,
        user: User.new(
          name: "John Doe",
          email: "john.doe@example.com",
          password: "password",
          password_confirmation: "password",
          role: "job_seeker"
        )
      )
      expect(job).not_to be_valid
    end

    # Add more validation tests as per your Job model's validation rules
  end

  # Add any other custom model logic tests as needed

  context "associations" do
    it "belongs to a user" do
      user = User.new(
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      job = Job.new(
        title: "Software Engineer",
        description: "Looking for a talented software engineer.",
        user: user
      )
      expect(job.user).to eq(user)
    end
  end
end
