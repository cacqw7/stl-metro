require 'rails_helper'

feature 'Lists of Routes', type: :feature do
  scenario 'visitor finds route by clicking on it' do
    p_heights = FactoryGirl.create(
      :route,
      route_short_name: '29',
      route_long_name: 'Princeton Heights'
    )
    FactoryGirl.create(
      :route,
      route_short_name: '666X',
      route_long_name: 'West County Express'
    )

    visit routes_path

    expect(page).to have_content 'Princeton Heights'
    expect(page).to have_content 'West County Express'

    click_link "29 Princeton Heights"

    expect(current_path).to eq route_path(p_heights)

    within "h1" do
      expect(page).to have_content "29 Princeton Heights"
    end
  end
end
