require 'rails_helper.rb'

# This example is to test the new page or the Create part of CRUD/REST
feature 'Creating posts' do
    scenario 'can create a house post' do
       visit '/'
       click_link 'New Post'
       fill_in 'Customer Name', with: 'John Mayer'
       fill_in 'Customer Email', with: 'john@test.com'
       fill_in 'Customer Phone no', with: '123456789'
       fill_in 'House Name', with: 'Casa de John'
       fill_in 'House Address', with: 'House 123, street 83, 5th and Lincoln'
       fill_in 'Description', with: 'Amazing house this is'
       attach_file('Image', "spec/files/images/house.jpg")

       choose('Rent')
       click_button 'Create Post'
       
       expect(page).to have_content('John Mayer')
       expect(page).to have_css("img[src*='house.jpg']")
    end
    
    it 'requires an image to create a post' do
       visit '/'
       click_link 'New Post'
       fill_in 'Customer Name', with: 'John Mayer'
       click_button 'Create Post'
       expect(page).to have_content('Missing Details! Please fill out the required details!')
    end
end