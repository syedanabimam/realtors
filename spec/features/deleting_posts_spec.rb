require 'rails_helper'

# This example is to test the delete page or the Delete part of CRUD/REST
feature 'Deleting posts' do  
  background do
    post = create(:post, customer_name: "cust1", customer_email: "cust1@test.com")

    visit '/'

    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit Post'
  end
  scenario 'Can delete a single post' do
    click_link 'Delete Post'

    expect(page).to have_content('Post deleted!')
    expect(page).to_not have_content('cust1')
  end
end 