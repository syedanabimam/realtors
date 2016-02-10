# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    customer_name "MyString"
    customer_email "MyString"
    customer_phone_no "MyString"
    house_name "MyString"
    house_address "MyString"
    description "MyString"
    post_type_select "MyString"
    image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/house.jpg', 'image/jpg')
  end
end
