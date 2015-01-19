require 'rails_helper'

feature 'liking photos' do

  before do
    stag = Photo.create(name: 'stag')
  end

  scenario 'a user can like a photo, which updates the photo like count', js: true do

    visit '/photos'
    click_link 'Like stag'
    expect(page).to have_content('1 Like')

  end
end
