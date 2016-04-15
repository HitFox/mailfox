require "rails_helper"

describe "main integration spec", js: true do
  describe "adds an email to the newsletter" do
    it "displays success for valid email" do
      visit "/main/index"

      fill_in "newsletter_email_address", with: "example@example.com"

      click_button "Submit"

      expect(page).to have_content("Success")
    end
  end

  describe "it displays error message for invalid email" do
    it "displays errors for an invalid email" do
      visit "/main/index"

      fill_in "newsletter_email_address", with: "example"

      click_button "Submit"

      expect(page).to have_content("Email is invalid")
    end
  end
end
