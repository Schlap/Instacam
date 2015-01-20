require 'rails_helper'

describe 'tagging posts' do

  before do
    charlie = User.create(:email => 'user@example.com', :password => '12345678')
  end

  it 'displayed the tags on the posts page' do
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: '12345678'
    click_button 'Log in'
    click_link 'Add a photo'
    fill_in 'Title', with: 'My fav post'
    attach_file '', Rails.root.join('./public/images/medium/missing.png')
    fill_in 'Tags', with: 'yolo, swag'
    click_button 'Create Photo'
    expect(page).to have_link '#yolo'
    expect(page).to have_link '#swag'

  end
end
