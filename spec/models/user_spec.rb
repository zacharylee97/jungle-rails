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
  end
end
