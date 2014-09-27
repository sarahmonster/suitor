class AddBasicUserSettings < ActiveRecord::Migration
  def change
    add_column :users, :application_goal, :integer, :default => 7
    add_column :users, :followup_offset, :integer, :default => 14
  end
end
