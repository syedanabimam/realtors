require 'rails_helper'

feature 'Editing posts' do  
  background do
    job = create(:post)

    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit Post'
  end
  scenario 'Can edit a post' do
    fill_in 'Customer Name', with: "John H Drumster"
    click_button 'Update Post'

    expect(page).to have_content("Post updated")
    expect(page).to have_content("John H Drumster")
  end
end  