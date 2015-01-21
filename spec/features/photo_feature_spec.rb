require 'rails_helper'

feature 'photos' do

  context 'no photos have been added' do

    scenario 'should display a prompt to add a photo' do
      visit '/photos'
      expect(page).to have_content 'No photos have been added yet'
      expect(page).not_to have_link 'Add a photo'
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
      sign_up
      find('#upload-photo-icon').click
      fill_in 'Title', with: 'Holiday in Turkey'
      click_button 'Create Photo'
      expect(page).to have_content 'Holiday in Turkey'
      expect(current_path).to eq '/photos'
    end

    context 'an invalid photo' do
      it 'does not let you submit a name that is too short' do
        visit '/photos'
        sign_up
        find('#upload-photo-icon').click
        fill_in 'Title', with: 'ST'
        click_button 'Create Photo'
        expect(page).not_to have_css 'h2', text: 'ST'
        expect(page).to have_content 'error'
      end
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


def sign_up
  find("#sign-up-icon").click
  fill_in 'Email', with: 'hadi@gmail.com'
  fill_in 'Password', with: '12345678'
  fill_in 'Password confirmation', with: '12345678'
  click_button 'Sign up'
end
