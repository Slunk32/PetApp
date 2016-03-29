require 'rails_helper'

#, :js => true

RSpec.feature "PetsApis", type: :feature do
  describe "As a user I can" do

    #test for logging in
    it "should be able to login successfully" do
      register
      click_on 'Logout'
      login
    end

    it "should be able to register successfully" do
      register
    end

    # Tests for visiting and making a new dog
    it "should visit the pets listing page" do
      register
      expect(page).to have_content('Pet Listing')
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
      expect(page).to have_content('92111')
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

    it 'should not allow you go create a pet without an image' do
      register
      create_a_dog
      expect(page).to have_content("Image can't be blank")
    end

    #---------------methods for testing------------------------
    def register
      visit '/welcome/index'
      click_on 'Register'
      fill_in 'user[email]', with: 'vince@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Sign up'
    end

    def login
      visit '/welcome/index'
      #login button on login form is a link? and is has a uppercase 'in'
      click_on 'Log In'
      fill_in 'user[email]', with: 'vince@gmail.com'
      fill_in 'user[password]', with: 'password'
      #login button on login form is a link? and is has a lowercase 'in'
      click_link 'Log in'
    end

    def create_a_dog
      find("#navbar_user_name").click
      click_link('New Pet')
      fill_in 'pet[name]', with: 'Bob'
      fill_in 'pet[breed]', with: 'Collie'
      find('#pet_size').find(:xpath, 'option[3]').select_option
      fill_in 'pet[age]', with: '5'
      fill_in 'pet_zipcode', with: '92111'
      click_on 'Create Pet'
    end
    # -----------------------------------------------------------


  end # the end for describe "As a user I can" do

end # the end for RSpec.feature "PetsApis", type: :feature do
