require 'spec_helper'
require 'rails_helper'

feature "Goals" do
  before(:each) { sign_in_as_sadclown }

  feature "adding goals" do
    before(:all) do
      # User.create(username: "sadclown", password: "sadness")
      # User.create(username: "happyclown", password: "sohappy")
      #login(User.find(1))
    end

    before(:each) { visit user_url(User.find_by_username("sadclown")) }

    scenario "user's page has an add goals button" do
      expect(page).to have_content("Add Goal")
    end

    feature "add goal page" do
      before(:each) { click_on "Add Goal" }

      scenario "has an add goals page" do
        expect(page).to have_content("Add Goal")
      end

      scenario "has fields for all columns" do
        expect(page).to have_content("Goal")
      end

      scenario "new goal appears on the user's homepage" do
        fill_in 'Goal', with: 'Finish Capybara spec!'
        click_on 'Add Goal'
        save_and_open_page
        expect(page).to have_content("Finish Capybara spec!")
      end
    end
  end

  feature "viewing own goals" do
    before(:all) do
      # User.create(username: "sadclown", password: "sadness")
      # User.create(username: "happyclown", password: "sohappy")
    #  login(User.find(1))
      FactoryGirl.create(:goal, goal_name: "First goal", user_id: 1)
      FactoryGirl.create(:goal, goal_name: "Second goal", user_id: 1)
      FactoryGirl.create(:goal, goal_name: "Secret goal", priv: true, user_id: 1)
    end

    before(:each) { visit user_url(1) }

    scenario "user's home page lists all goals" do
      expect(page).to have_content("First goal")
      expect(page).to have_content("Second goal")
    end

    scenario "user's home page lists their own private goals" do
      expect(page).to have_content("Secret goal")
    end
  end

  feature "viewing other user's goals" do
    before(:all) do
      # User.create(username: "sadclown", password: "sadness")
      # User.create(username: "happyclown", password: "sohappy")
      #login(User.find(1))
      FactoryGirl.create(:goal, goal_name: "First goal", user_id: 2)
      FactoryGirl.create(:goal, goal_name: "Second goal", user_id: 2)
      FactoryGirl.create(:goal, goal_name: "Secret goal", priv: true, user_id: 2)
    end

    before(:each) { visit user_url(2) }

    scenario "other user's page shows their public goals" do
      expect(page).to have_content("First goal")
      expect(page).to have_content("Second goal")
    end

    scenario "other user's page does not show their private goals" do
      expect(page).to_not have_content("Secret goal")
    end
  end

  feature "updating goals" do
    before(:all) do
      # User.create(username: "sadclown", password: "sadness")
      # User.create(username: "happyclown", password: "sohappy")
      #login(User.find(1))
    end

    scenario "user's page has links to update goal" do
      FactoryGirl.create(:goal, goal_name: "First goal", user_id: 1)
      visit user_url(1)
      expect(page).to have_content("Update Goal")
    end

    scenario "button not available to other users" do
      FactoryGirl.create(:goal, goal_name: "First goal", user_id: 2)
      visit user_url(2)
      expect(page).to_not have_content("Update Goal")
    end

    feature "update goal page" do
      before(:each) do
        FactoryGirl.create(:goal, goal_name: "First goal", user_id: 1)
        visit user_url(1)
        click_on "Update Goal"
      end

      scenario "has an update goal page" do
        expect(page).to have_content("Update Goal")
      end

      scenario "pre-fills form with goal values" do
        expect(page).to have_content("First Goal")
      end

      scenario "after update, redirects to user's homepage" do
        click_on "Update"
        expect(response).to redirect_to(user_url(1))
      end
    end
  end

  feature "completing goals" do
    before(:all) do
      # User.create(username: "sadclown", password: "sadness")
      # User.create(username: "happyclown", password: "sohappy")
      #login(User.find(1))
    end

    scenario "user's page has links to complete goal" do
      FactoryGirl.create(:goal, user_id: 1)
      visit user_url(1)
      expect(page).to have_content("Complete!")
    end

    scenario "button not available to other users" do
      FactoryGirl.create(:goal, user_id: 2)
      visit user_url(2)
      expect(page).to_not have_content("Complete!")
    end

    scenario "completed goals show 'Completed'" do
      FactoryGirl.create(:goal, user_id: 1)
      visit user_url(1)
      click_on "Complete!"
      expect(page).to have_content("Completed")
      expect(Goal.find(1).completed).to be true
    end
  end

  feature "deleting goals" do
    before(:all) do
      # User.create(username: "sadclown", password: "sadness")
      # User.create(username: "happyclown", password: "sohappy")
      #login(User.find(1))
    end

    before(:all) { FactoryGirl.create(:goal, goal_name: "First Goal", user_id: 1) }

    scenario "user's page has links to delete goal" do
      visit user_url(1)
      expect(page).to have_content("Delete Goal")
    end

    scenario "button not available to other users" do
      FactoryGirl.create(:goal, user_id: 2)
      visit user_url(2)
      expect(page).to_not have_content("Delete Goal")
    end

    scenario "after delete, no longer appears on user's page" do
      visit user_url(1)
      expect(page).to have_content("First Goal")
      click_on "Delete Goal"
      expect(page).to_not have_content("First Goal")
    end

    scenario "shows 'Goal deleted!' after deleting a goal" do
      visit user_url(1)
      click_on "Delete Goal"
      expect(page).to have_content("Goal deleted!")
    end
  end
end
