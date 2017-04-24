require 'rails_helper'

feature 'Lists of Routes', type: :feature do
  scenario 'visitor finds route by clicking on it' do
    FactoryGirl.create(
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
  end
end
