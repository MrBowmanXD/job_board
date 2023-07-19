require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      user = User.new(
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user = User.new(
        name: nil,
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      expect(user).not_to be_valid
    end

    it "is not valid without an email" do
      user = User.new(
        name: "John Doe",
        email: nil,
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      expect(user).not_to be_valid
    end

    it "is not valid without a role" do
      user = User.new(
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: nil
      )
      expect(user).not_to be_valid
    end

    it "is not valid with a duplicate email" do
      User.create(
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      user = User.new(
        name: "Jane Smith",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      expect(user).not_to be_valid
    end
  end

  # Add more tests as needed for any additional model logic or methods.

  context "devise authentication" do
    it "should authenticate a valid user with correct password" do
      user = User.create(
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      expect(user.valid_password?("password")).to be true
    end

    it "should not authenticate a valid user with incorrect password" do
      user = User.create(
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      expect(user.valid_password?("wrong_password")).to be false
    end

    it "should encrypt the password" do
      user = User.new(
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      user.save
      expect(user.encrypted_password).not_to eq("password")
    end
  end

  context "devise registration" do
    it "should allow a user to be registered" do
      user_count_before_registration = User.count
      user = User.new(
        name: "John Doe",
        email: "john.doe@example.com",
        password: "password",
        password_confirmation: "password",
        role: "job_seeker"
      )
      user.save
      expect(User.count).to eq(user_count_before_registration + 1)
    end

    # Nevermind this test since job_seeker is not a default role

    # it "should set a default role as 'job_seeker' during registration" do
    #   user = User.create(
    #     name: "John Doe",
    #     email: "john.doe@example.com",
    #     password: "password",
    #     password_confirmation: "password"
    #   )
    #   expect(user.role).to eq("job_seeker")
    # end
  end

end
