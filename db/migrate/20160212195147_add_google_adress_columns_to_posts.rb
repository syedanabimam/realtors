class AddGoogleAdressColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :country, :string
    add_column :posts, :city, :string
  end
end
