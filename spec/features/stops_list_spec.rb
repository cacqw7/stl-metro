require "rails_helper"

feature "Lists of Stops", type: :feature do
  scenario "visitor finds stop by clicking on it" do
    shaw = FactoryGirl.create(:stop, stop_name: 'Shaw')
    FactoryGirl.create(:stop, stop_name: 'Stadium')

    visit root_path

    expect(page).to have_content 'Shaw'
    expect(page).to have_content 'Stadium'
  end
end
