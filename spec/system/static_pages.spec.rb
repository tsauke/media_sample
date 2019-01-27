require 'rails_helper'

RSpec.describe "Static_pages_system", type: :system do

  scenario "homeへページ遷移できるか" do
      visit root_path
      click_link "Home"

      expect(page).to have_content("Connect")
    end

    scenario "aboutへページ遷移できるか" do
      visit root_path
      click_link "About"

      expect(page).to have_content("Home Help Log in About")
    end

    scenario "helpへページ遷移できるか" do
      visit root_path
      click_link "Help"

      expect(page).to have_content("Log in Help")
    end

    scenario "contactへページ遷移できるか" do
      visit root_path
      click_link "Contact"

      expect(page).to have_content("Help Log in Contact")
    end

    scenario "Sgin upへページ遷移できるか" do
      visit root_path
      click_on "登録する"

      expect(page).to have_content("Sign up")
    end
  end
