require 'rails_helper'

context "user not signed in and on the homepage" do
  it "should see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).to have_selector('#sign-in-icon')
    expect(page).to have_selector('#sign-up-icon')
  end

  it "should not see 'sign out' link" do
    visit('/')
    expect(page).not_to have_selector('#sign-out-icon')
  end

  it "should not see add a photo link" do
    visit('/')
    expect(page).not_to have_link("Add a photo")
  end
end

context "user signed in on the homepage" do

  before do
    visit('/')
    find('#sign-up-icon').click
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  it "should see 'sign out' link" do
    visit('/')
    expect(page).to have_selector('#sign-out-icon')
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end

  it "can only delete or edit photos they have created" do
    sign_in("bob@gmail.com", "87654321")
    find('#upload-photo-icon').click
    fill_in("Title", with: 'Je Suis Charlie')
    click_button "Create Photo"
    find('#sign-out-icon').click
    sign_in("tom@gmail.com", "12345678")
    expect(page).to have_content("Je Suis Charlie")
    expect(page).not_to have_content("Edit Je Suis Charlie")
    expect(page).not_to have_content("Delete Je Suis Charlie")
  end
end


def sign_in(email, password)
  User.create(:email => email, :password => password)
  visit('/')
end
