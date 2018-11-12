require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "my_email@email.com",
                      password: "my_password", password_confirmation: "my_password")
      expect(@user.save).to eq true
    end
    it "is not valid without first_name" do
      @user = User.new(first_name: nil, last_name: "last_name", email: "my_email@email.com",
                      password: "my_password", password_confirmation: "my_password")
      expect(@user.save).to eq false
    end
    it "is not valid without last_name" do
      @user = User.new(first_name: "first_name", last_name: nil, email: "my_email@email.com",
                      password: "my_password", password_confirmation: "my_password")
      expect(@user.save).to eq false
    end
    it "is not valid without email" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: nil,
                      password: "my_password", password_confirmation: "my_password")
      expect(@user.save).to eq false
    end
    it "should not save a user that has the same email" do
      @user1 = User.new(first_name: "first_name", last_name: "last_name", email: "TEST@TEST.com",
                        password: "my_password", password_confirmation: "my_password")
      @user1.save
      @user2 = User.new(first_name: "first_name", last_name: "last_name", email: "test@test.COM",
                        password: "my_password", password_confirmation: "my_password")
      expect(@user2.save).to eq false
    end
    it "is not valid without password" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "my_email@email.com",
                      password: nil, password_confirmation: "my_password")
      expect(@user.save).to eq false
    end
    it "is not valid without password_confirmation" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "my_email@email.com",
                      password: "my_password", password_confirmation: nil)
      expect(@user.save).to eq false
    end
    it "is not valid if password does not match password_confirmation" do
      @user = User.new(first_name: "first_name", last_name: "last_name", email: "my_email@email.com",
                      password: "my_password", password_confirmation: "not_my_password")
      expect(@user.save).to eq false
    end
  end
end
