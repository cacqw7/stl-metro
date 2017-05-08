require "rails_helper"

feature "List of Stops", type: :feature do
  scenario "visitor finds stop by clicking on it" do
    shaw = create(:stop, stop_name: 'Grand @ Shaw')
    create(:stop, stop_name: 'Stadium')

    visit root_path

    expect(page).to have_content 'Shaw'
    expect(page).to have_content 'Stadium'

    click_link "Shaw"

    expect(current_path).to eq stop_path(shaw)

    within "h1" do
      expect(page).to have_content "Grand @ Shaw"
    end
  end
end
