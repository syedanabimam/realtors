class AddColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :status, :string
    add_column :posts, :rent_price, :string
  end
end
