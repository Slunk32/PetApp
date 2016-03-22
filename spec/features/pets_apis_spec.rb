require 'rails_helper'

RSpec.feature "PetsApis", type: :feature do
  describe "As a user I can" do
    it "should visit the pets listing page" do
      visit 'pets'
      expect(page).to have_content('Listing Pets')
    end
    it 'will allow me to create a dog' do
      create_a_dog
    end

    it 'will display the new pet in the listing' do
      create_a_dog
      click_on 'Back'
      expect(page).to have_content('Bob')
      expect(page).to have_content('Collie')
      expect(page).to have_content('Medium')
      expect(page).to have_content('5')
    end

    it 'should allow us to update the dog info' do
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


    def create_a_dog
      visit 'pets/new'
      fill_in 'pet[name]', with: 'Bob'
      find('#pet_breed').find(:xpath, 'option[3]').select_option
      find('#pet_size').find(:xpath, 'option[3]').select_option
      fill_in 'pet[age]', with: '5'
      click_on 'Create Pet'
      expect(page).to have_content('Pet was successfully created')
    end
  end
end
