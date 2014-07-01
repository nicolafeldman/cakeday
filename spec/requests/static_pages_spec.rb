require 'spec_helper'

describe "Static pages" do

  describe "Registration page" do

    it "should have the content 'Sign up here'" do
      visit '/static_pages/registration'
      expect(page).to have_content('Sign up here')
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
  end

  describe "About page" do

    it "should have the content 'About this app'" do
      visit '/static_pages/about'
      expect(page).to have_content('About this app')
    end
  end
end
