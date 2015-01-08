require 'rails_helper'

feature 'photos' do
  context 'no photos have been added' do
    scenario 'should display a prompt to add a photo' do
      visit '/photos'
      expect(page).to have_content 'No photos'
      expect(page).to have_link 'Add a photo'
    end
  end

  context 'have been added' do
    before do
      Photo.create(name: 'Holiday in Turkey')
    end

    scenario 'display photos' do
      visit '/photos'
      expect(page).to have_content('Holiday in Turkey')
      expect(page).not_to have_content('No photos yet')
    end
  end

  context 'creating photos' do
    scenario 'prompts user to fill out a form, then displays the new photo' do
      visit '/photos'
      click_link 'Add a photo'
      fill_in 'Name', with: 'Holiday in Turkey'
      click_button 'Create Photo'
      expect(page).to have_content 'Holiday in Turkey'
      expect(current_path).to eq '/photos'
    end
  end

  context 'viewing photos' do

    let!(:stag){Photo.create(name:'STAG')}

    scenario 'lets a user view a photo' do
      visit '/photos'
      click_link 'STAG'
      expect(page).to have_content 'STAG'
      expect(current_path).to eq "/photos/#{stag.id}"
    end
  end
end
