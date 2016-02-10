class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :customer_name
      t.string :customer_email
      t.string :customer_phone_no
      t.string :house_name
      t.string :house_address
      t.string :description
      t.string :post_type_select

      t.timestamps
    end
  end
end
