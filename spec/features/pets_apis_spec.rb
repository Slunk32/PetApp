require 'rails_helper'

RSpec.feature "PetsApis", type: :feature do
  describe "As a user I can" do

    #test for logging in
    it "should be able to login successfully" do
      login
    end
    it "should be able to register successfully" do
      register
    end

    # Tests for visiting and making a new dog
    it "should visit the pets listing page" do
      register
      expect(page).to have_content('Listing Pets')
    end

    it 'will allow me to create a dog' do
      register
      create_a_dog
    end

    it 'will display the new pet in the listing' do
      register
      create_a_dog
      click_on 'Back'
      expect(page).to have_content('Bob')
      expect(page).to have_content('Collie')
      expect(page).to have_content('Medium')
      expect(page).to have_content('5')
    end

    it 'should allow us to update the dog info' do
      register
      create_a_dog
      click_on 'Back'
      click_on 'Edit'
      fill_in 'pet[name]', with: 'Roland'
      find('#pet_breed').find(:xpath, 'option[2]').select_option
      click_on 'Update Pet'
      click_on 'Back'
      expect(page).to have_content('Roland')
      expect(page).to have_content('German Shephard')
    end

    def login
        visit 'welcome/index'
        click_on 'Sign In'
        fill_in 'user[email]', with: 'vince@gmail.com'
        fill_in 'user[password]', with: 'password'
        click_on 'Log in'
    end

    def register
      visit 'welcome/index'
      click_on 'Register'
      fill_in 'user[email]', with: 'vince@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on 'Sign up'
    end

    def create_a_dog
      click_link('New Pet')
      fill_in 'pet[name]', with: 'Bob'
      find('#pet_breed').find(:xpath, 'option[3]').select_option
      find('#pet_size').find(:xpath, 'option[3]').select_option
      fill_in 'pet[age]', with: '5'
      click_on 'Create Pet'
      expect(page).to have_content('Pet was successfully created')
    end
  end
end
