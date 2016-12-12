require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: "test"
      fill_in 'Password', with: "123456"
      click_on "Create User"
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "test"
    end
  end

end

feature "logging in" do
  before(:each) do
    FactoryGirl.create(:user)
    visit new_session_url
    fill_in 'Username', with: "test"
    fill_in 'Password', with: "123456"
    click_on "Sign In"
  end

  scenario "shows username on the homepage after login" do
    expect(page).to have_content "test"
  end

end

feature "logging out" do
  before(:each) do
    FactoryGirl.create(:user)
    visit new_session_url
    fill_in 'Username', with: "test"
    fill_in 'Password', with: "123456"
    click_on "Sign In"
    click_on "Sign Out"
  end

  scenario "begins with a logged out state" do
    expect(page).to_not have_content "Sign Out"
  end

  scenario "doesn't show username on the homepage after logout" do
    expect(page).to_not have_content "test"
  end

end
