require 'rails_helper'

# shows you how the tests are running
#, :js => true

RSpec.feature "PetsApis", type: :feature do
  describe "As an owner I" do

    #test for logging in
    it "should be able to login successfully for a renter" do
      owner_register
      click_on 'Logout'
      login
    end

    it "should be able to register successfully for an owner" do
      owner_register
    end

    # Tests for visiting and making a new dog
    it "should be able to visit the pets listing page" do
      owner_register
      expect(page).to have_content('Dog Listing')
    end

    it 'will allow an owner to create a dog' do
      owner_register
      create_a_dog
    end

    it 'will display the new pet in the listing' do
      owner_register
      create_a_dog
      click_on 'Back'
      expect(page).to have_content('Bob')
      expect(page).to have_content('Collie')
      expect(page).to have_content('Medium')
      expect(page).to have_content('5')
      expect(page).to have_content('92111')
    end

    it 'should allow us to update the dog info' do
      owner_register
      create_a_dog
      click_on 'Back'
      click_link 'edit_link'
      fill_in 'pet[name]', with: 'Roland'
      fill_in 'pet[breed]', with: 'German Shephard'
      click_on 'Update Pet'
      click_on 'Back'
      expect(page).to have_content('Roland')
      expect(page).to have_content('German Shephard')
    end

    # This test is pending becuase selenium and capybara can't confirm the alert that pops up when It clicks delete.
    skip 'should allow us to delete the dog info' do
      owner_register
      create_a_dog
      click_on 'Back'
      find("#delete_link").click
      #---problem area----
      accept_alert do
        click_link('OK')
      end
      #-------------------
      expect(page).not_to have_content('Bob')
      expect(page).to have_content('Pet was successfully destroyed.')

    end
    #--------------------------Pending------------------------------------------

    it 'should not allow you to create a pet without an image' do
      owner_register
      find("#navbar_user_name").click
      click_link('New Pet')
      fill_in 'pet[name]', with: 'Bob'
      fill_in 'pet[breed]', with: 'Collie'
      find('#pet_size').find(:xpath, 'option[3]').select_option
      fill_in 'pet[age]', with: '5'
      fill_in 'pet_zipcode', with: '92111'
      click_on 'Create Pet'
      expect(page).to have_content("Image can't be blank")
    end

    it 'should schedule a pet appointment' do

    end

    # Rebecca's code to upload a new user and and image with paperclip
    # it "will allow a user to enter an email address, password, password confirm, upload an avatar and register" do
    #   visit "/users/sign_up"
    #   fill_in 'Email', with: 'J@yahoo.com'
    #   fill_in 'Password', with: 'password123'
    #   fill_in 'Password confirmation', with: 'password123'
    #   attach_file('user_avatar', '/Users/learn/Desktop/Coffeeshop-group-project/spec/Images/coffeecup.jpeg')
    #   click_button 'Sign Up'
    #   expect(page).to have_content("Welcome! You have signed up successfully.")
    # end


    #---------------methods for testing------------------------
    def owner_register
      visit '/welcome/index'
      click_on 'Register'
      fill_in 'user[email]', with: 'vince@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      select "Owner", :from => "user[user_type]"
      click_button 'Sign up'
    end

    def create_a_dog
      find("#navbar_user_name").click
      click_link('New Pet')
      fill_in 'pet[name]', with: 'Bob'
      fill_in 'pet[breed]', with: 'Collie'
      find('#pet_size').find(:xpath, 'option[3]').select_option
      fill_in 'pet[age]', with: '5'
      fill_in 'pet_zipcode', with: '92111'
      attach_file('paperclip_upload', '/Users/learn/desktop/Petapp/spec/img_test/animals-cute-dog-Favim.com-458661_large.jpg')
      click_on 'Create Pet'
    end
    # -----------------------------------------------------------


  end # the end for describe "As an owner I can" do

  describe "As a user I" do

    it "should be able to register successfully for an owner" do
      renter_register
    end

    def renter_register
      visit '/welcome/index'
      click_on 'Register'
      fill_in 'user[email]', with: 'vince@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      select "Renter", :from => "user[user_type]"
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
  end


end # the end for RSpec.feature "PetsApis", type: :feature do
