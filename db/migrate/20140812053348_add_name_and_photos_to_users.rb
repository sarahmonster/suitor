class AddNameAndPhotosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :photo, :string
  end
end
