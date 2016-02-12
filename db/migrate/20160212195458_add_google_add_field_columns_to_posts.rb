class AddGoogleAddFieldColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :google_address, :string
  end
end
