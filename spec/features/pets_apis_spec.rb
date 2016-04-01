require 'rails_helper'

# shows you how the tests are running
#, :js => true

RSpec.feature "PetsApis", type: :feature do

  #_______________________________________________________________________________
  # AS AN OWNER
  #_______________________________________________________________________________
  describe "As an owner I" do

    #test for logging in
    it "should be able to login successfully" do
      owner_register
      click_on 'Logout'
      owner_login
    end

    it "should be able to register successfully" do
      owner_register
    end

    # Tests for visiting and making a new dog
    it "should be able to visit the pets listing page" do
      owner_register
      expect(page).to have_content('Dog Listing')
    end

    it 'should be able to create a dog' do
      owner_register
      create_a_dog
    end

    it 'should see the new pet in the listing' do
      owner_register
      create_a_dog
      expect(page).to have_content('Bob')
      expect(page).to have_content('Collie')
      expect(page).to have_content('Medium')
      expect(page).to have_content('5')
      expect(page).to have_content('92111')
    end

    it 'should be able to update the dog info' do
      owner_register
      create_a_dog
      click_link 'edit_link'
      fill_in 'pet[name]', with: 'Roland'
      fill_in 'pet[breed]', with: 'German Shephard'
      click_on 'Update Pet'
      click_on 'Back'
      expect(page).to have_content('Roland')
      expect(page).to have_content('German Shephard')
    end

    it 'should only see the Owners dog that they made (as an owner)' do
      owner_register
      create_a_dog
      find('#Logout').click
      visit '/welcome/index'
      click_on 'Register'
      fill_in 'user[email]', with: 'russ@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      select "Owner", :from => "user[user_type]"
      click_button 'Sign up'
      expect(page).to_not have_content('Bob')
      expect(page).to_not have_content('Collie')
      expect(page).to_not have_content('Large')
      expect(page).to_not have_content('5')
      expect(page).to_not have_content('92111')
      find("#navbar_user_name").click
      click_link('New Pet')
      fill_in 'pet[name]', with: 'Gina'
      fill_in 'pet[breed]', with: 'Golden Retriever'
      find('#pet_size').find(:xpath, 'option[2]').select_option
      fill_in 'pet[age]', with: '2'
      fill_in 'pet_zipcode', with: '92117'
      attach_file('paperclip_upload', '/Users/learn/Desktop/PetApp/spec/img_test/animals-cute-dog-Favim.com-458661_large.jpg')
      click_on 'Create Pet'
      click_on 'Back'
      expect(page).to have_content('Gina')
      expect(page).to have_content('Golden retriever')
      expect(page).to have_content('Small')
      expect(page).to have_content('2')
      expect(page).to have_content('92117')
    end

    # This test is pending becuase selenium and capybara can't confirm the alert that pops up when It clicks delete.
    skip 'should be able to delete the dog info' do
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

    it 'should not not be able to create a pet without an image' do
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

    it 'should not be able to edit a pet they did not create' do
      owner_register
      create_a_dog
      find('#Logout').click
      owner_register_2
      visit '/pets/' + Pet.last.id.to_s + '/edit'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('You do not have access to this page.')
    end

    it "should not be able to schedule an appointment" do
      owner_register
      create_a_dog
      visit '/pets/' + Pet.last.id.to_s + '/appointments/new'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('You do not have access to this page.')
    end

    # Test for the phone numbers
    it 'should see the emergency contact phone number of the Renter' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
      expect(page).to have_content('3-333-333-3333')
      logout
      owner_login
      find("#navbar_user_name").click
      click_link('Your Appointments')
      expect(page).to have_content('Listing Appointments')
      page.find(:css, '#show_app', match: :first).click
      expect(page).to have_content('1-111-111-1111')
    end

    skip 'should view all the appointments for dogs I own so its easier to keep track of' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
      click_on 'Back'
      click_on 'Back'
      create_an_appointment_2
      click_on 'Back'
      click_on 'Back'
      find("#navbar_user_name").click
      click_link('Your Appointments')
      expect(page).to have_content('March 30, 2016')
      expect(page).to have_content('March 27, 2016')
    end

    skip 'should view all appointments for one pet' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
      expect(page).to have_content('3-333-333-3333')
      logout
      owner_register_2
      create_a_dog_2
      logout
      renter_login
      #----problem area---
      #here the page should click on the second dog
      page.find(:css, '#show_link', match: :first).click
      #-------------------
      expect(page).to have_content('Bob')

      # this is what we will test for once clicking one the second dog works
      #expect(page).to have_content('Woof')

      #saved code in case we need it
      # create_an_appointment
      # owner_login #owner_register_2
      # expect(page).to have_content('Dog Listing')
      # find("#navbar_user_name").click
      # click_link('Your Appointments')
      # expect(page).to have_content('Listing Appointments')

      #checklist for this test
      # (-) means its done
      # made Dog-
      # log out-
      # make renter-
      # create Appointments-
      # logout-
      # make new owner -
      # make dog -
      # logout -
      # login w renter -
      # make appt w new dog
      # logout
      # login- 1st owner
      # view Appointments
      # expect contect to not have new dog.
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



  end # the end for describe "As an owner I can" do

  #_______________________________________________________________________________
  # AS A RENTER
  #_______________________________________________________________________________

  describe "As a renter I" do

    it "should be able to register successfully for an owner" do
      visit '/welcome/index'
      renter_register
    end

    it 'should schedule a pet appointment' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
    end

    it 'should show all appointments' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
    end

    it 'should only allow dogs to be book with a specific time once' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
      click_on 'Back'
      click_link 'New Appointment'
      expect(page).to have_content('Date')
      fill_in 'appointment[date]', with: '03/30/2016'
      expect(page).to have_content('Bob')
      expect(page).to have_content('andrew@gmail.com')
      click_on 'Create Appointment'
      expect(page).to have_content("Date already exists")
    end

    it 'should only allow one renter to book a specific dog at a spcific date' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
      logout
      click_on 'Register'
      fill_in 'user[email]', with: 'russ@gmail.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      select "Renter", :from => "user[user_type]"
      click_button 'Sign up'
      page.find("#show_link").click
      expect(page).to have_content('New Appointment')
      expect(page).to have_content('Bob')
      expect(page).to have_content('russ@gmail.com')
      click_link 'New Appointment'
      expect(page).to have_content('Date')
      fill_in 'appointment[date]', with: '03/30/2016'
      click_on 'Create Appointment'
      expect(page).to have_content("Date already exists")
    end

    it 'can sort the pet list name column by asc/desc' do
      owner_register
      create_a_dog
      create_a_dog_2
      create_a_dog_3
      find('#Logout').click
      renter_register
      expect(page.find('#nameheader a')[:class]).to eq('current asc')
      find('#nameheader a').click
      expect(page.find('#nameheader a')[:class]).to eq('current desc')
    end

    it 'can sort the pet list breed column by asc/desc' do
      owner_register
      create_a_dog
      create_a_dog_2
      create_a_dog_3
      find('#Logout').click
      renter_register
      expect(page.find('#nameheader a')[:class]).to eq('current asc')
      find('#breedheader a').click
      expect(page.find('#breedheader a')[:class]).to eq('current asc')
      find('#breedheader a').click
      expect(page.find('#breedheader a')[:class]).to eq('current desc')
    end

    it 'can sort the pet list size column by asc/desc' do
      owner_register
      create_a_dog
      create_a_dog_2
      create_a_dog_3
      find('#Logout').click
      renter_register
      expect(page.find('#nameheader a')[:class]).to eq('current asc')
      find('#sizeheader a').click
      expect(page.find('#sizeheader a')[:class]).to eq('current asc')
      find('#sizeheader a').click
      expect(page.find('#sizeheader a')[:class]).to eq('current desc')
    end

    it 'can sort the pet list age column by asc/desc' do
      owner_register
      create_a_dog
      create_a_dog_2
      create_a_dog_3
      find('#Logout').click
      renter_register
      expect(page.find('#nameheader a')[:class]).to eq('current asc')
      find('#ageheader a').click
      expect(page.find('#ageheader a')[:class]).to eq('current asc')
      find('#ageheader a').click
      expect(page.find('#ageheader a')[:class]).to eq('current desc')
    end

    it 'can sort the pet list location column by asc/desc' do
      owner_register
      create_a_dog
      create_a_dog_2
      create_a_dog_3
      find('#Logout').click
      renter_register
      expect(page.find('#nameheader a')[:class]).to eq('current asc')
      find('#zipcodeheader a').click
      expect(page.find('#zipcodeheader a')[:class]).to eq('current asc')
      find('#zipcodeheader a').click
      expect(page.find('#zipcodeheader a')[:class]).to eq('current desc')
    end

    it 'cannot create a pet' do
      renter_register
      visit '/pets/new'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('You do not have access to this page.')
    end

    it 'cannot edit a pet' do
      owner_register
      create_a_dog
      find('#Logout').click
      renter_register
      visit '/pets/' + Pet.last.id.to_s + '/edit'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('You do not have access to this page.')
    end

    it 'should not be able to edit another renters appointment' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
      logout
      renter_register_2
      visit '/appointments/' + Appointment.last.id.to_s + '/edit'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('You do not have access to this page.')
    end

    # Test for the phone numbers
    it 'should see the emergency contact phone number of the Owner' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
      expect(page).to have_content('3-333-333-3333')
    end

    it 'should see the dog owners location on a map when I go to create an appt' do
      owner_register
      create_a_dog
      logout
      renter_register
      page.find(:css, "#show_link", match: :first).click
      expect(page).to have_content('New Appointment')
      expect(page).to have_content('Bob')
      expect(page).to have_content('andrew@gmail.com')
      click_link 'New Appointment'
      expect(page).to have_content('Date')
      fill_in 'appointment[date]', with: '03/30/2016'
      expect(page).to have_content('Bob')
      expect(page).to have_content('andrew@gmail.com')
      expect(page.find('#mapcontainer div')[:id]).to eq('map')
    end

    it 'should view appiontments I made so I can keep track of when I will be taking care of a dog' do
      owner_register
      create_a_dog
      logout
      renter_register
      create_an_appointment
      click_on 'Back'
      click_on 'Back'
      create_an_appointment_2
      click_on 'Back'
      click_on 'Back'
      find("#navbar_user_name").click
      click_link('Your Appointments')
      expect(page).to have_content('March 30, 2016')
      expect(page).to have_content('March 27, 2016')
    end
  end # the end for describe "As a renter I" do

  #_______________________________________________________________________________
  # AS A User
  #_______________________________________________________________________________

  describe "As a User I" do
    it "can update my profile with an avatar" do
      renter_register
      find("#navbar_user_name").click
      click_link('Your Profile (Renter)')
      click_link('Edit')
      attach_file('user_avatar', '/Users/learn/desktop/Petapp/spec/img_test/animals-cute-dog-Favim.com-458661_large.jpg')
      fill_in 'user[current_password]', with: 'password'
      click_button 'Update'
    end

  end # the end for describe "As a User I" do

  #_______________________________________________________________________________
  #---------------methods for testing------------------------
  #_______________________________________________________________________________

  def renter_register
    visit '/welcome/index'
    click_on 'Register'
    fill_in 'user[email]', with: 'andrew@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    select "Renter", :from => "user[user_type]"
    fill_in 'user_phone_number', with: '1-111-111-1111'
    click_button 'Sign up'
  end

  def renter_register_2
    visit '/welcome/index'
    click_on 'Register'
    fill_in 'user[email]', with: 'shmuck@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    select "Renter", :from => "user[user_type]"
    fill_in 'user_phone_number', with: '2-222-222-2222'
    click_button 'Sign up'
  end

  def owner_register
    visit '/welcome/index'
    click_on 'Register'
    fill_in 'user[email]', with: 'vince@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    fill_in 'user[address]', with: '8303 Ray Street, San Diego CA'
    select "Owner", :from => "user[user_type]"
    fill_in 'user_phone_number', with: '3-333-333-3333'
    click_button 'Sign up'
  end

  def owner_register_2
    visit '/welcome/index'
    click_on 'Register'
    fill_in 'user[email]', with: 'yosef@gmail.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    fill_in 'user[address]', with: '8303 Ray Street, San Diego CA'
    select "Owner", :from => "user[user_type]"
    fill_in 'user_phone_number', with: '4-444-444-4444'
    click_button 'Sign up'
  end

  def renter_login
    visit '/welcome/index'
    #login button on login form is a link? and is has a uppercase 'in'
    click_on 'Log In'
    fill_in 'user[email]', with: 'andrew@gmail.com'
    fill_in 'user[password]', with: 'password'
    #login button on login form is a link? and is has a lowercase 'in'
    click_button 'Log in'
  end

  def owner_login
    visit '/welcome/index'
    #login button on login form is a link? and is has a uppercase 'in'
    click_on 'Log In'
    fill_in 'user[email]', with: 'vince@gmail.com'
    fill_in 'user[password]', with: 'password'
    #login button on login form is a link? and is has a lowercase 'in'
    click_button 'Log in'
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
    click_on 'Back'
  end

  def create_an_appointment
    page.find(:css, "#show_link", match: :first).click
    expect(page).to have_content('New Appointment')
    expect(page).to have_content('Bob')
    expect(page).to have_content('andrew@gmail.com')
    click_link 'New Appointment'
    expect(page).to have_content('Date')
    fill_in 'appointment[date]', with: '03/30/2016'
    expect(page).to have_content('Bob')
    expect(page).to have_content('andrew@gmail.com')
    click_on 'Create Appointment'
    expect(page).to have_content("Appointment was successfully created.")
    expect(page).to have_content('March 30, 2016')
  end

  def create_an_appointment_2
    page.find("#show_link").click
    expect(page).to have_content('New Appointment')
    expect(page).to have_content('Bob')
    expect(page).to have_content('andrew@gmail.com')
    click_link 'New Appointment'
    expect(page).to have_content('Date')
    fill_in 'appointment[date]', with: '03/27/2016'
    expect(page).to have_content('Bob')
    expect(page).to have_content('andrew@gmail.com')
    click_on 'Create Appointment'
    expect(page).to have_content("Appointment was successfully created.")
    expect(page).to have_content('March 27, 2016')
  end

  def logout
    find('#Logout').click
  end

  def create_a_dog_2
    find("#navbar_user_name").click
    click_link('New Pet')
    fill_in 'pet[name]', with: 'Woof'
    fill_in 'pet[breed]', with: 'Shitsu'
    find('#pet_size').find(:xpath, 'option[1]').select_option
    fill_in 'pet[age]', with: '4'
    fill_in 'pet_zipcode', with: '92122'
    attach_file('paperclip_upload', '/Users/learn/desktop/Petapp/spec/img_test/animals-cute-dog-Favim.com-458661_large.jpg')
    click_on 'Create Pet'
  end

  def create_a_dog_3
    find("#navbar_user_name").click
    click_link('New Pet')
    fill_in 'pet[name]', with: 'Sam'
    fill_in 'pet[breed]', with: 'Golden Retriever'
    find('#pet_size').find(:xpath, 'option[3]').select_option
    fill_in 'pet[age]', with: '1'
    fill_in 'pet_zipcode', with: '92037'
    attach_file('paperclip_upload', '/Users/learn/desktop/Petapp/spec/img_test/animals-cute-dog-Favim.com-458661_large.jpg')
    click_on 'Create Pet'
  end

end # the end for RSpec.feature "PetsApis", type: :feature do
