require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
 #SETUP
  before :each do
    User.create!(first_name: "first_name", last_name: "last_name", email: "my_email@email.com",
                password: "my_password", password_confirmation: "my_password")
  end

  scenario "They login using their user details" do
    #ACT
    visit root_path
    click_link("Login")
    fill_in "email", with: "my_email@email.com"
    fill_in "password", with: "my_password"
    click_button "Submit"
    #DEBUG
    save_screenshot
    #VERIFY
    expect(page).to have_css("div.login", text: "Signed in as first_name")
  end
end