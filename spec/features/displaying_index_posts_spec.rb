require 'rails_helper'

# This example is to test the index page whether it can show newly created posts
feature 'Index displays a list of posts' do  
  scenario 'the index displays correct created job information' do
    job_one = create(:post, customer_name: "cust1", customer_email: "cust1@test.com")
    job_two = create(:post, customer_name: "cust2", customer_email: "cust2@test.com")

    visit '/'
    expect(page).to have_content("cust1")
    expect(page).to have_content("cust2")
    expect(page).to have_css("img[src*='house']")
  end
end