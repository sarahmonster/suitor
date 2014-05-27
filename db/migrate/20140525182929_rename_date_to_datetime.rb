class RenameDateToDatetime < ActiveRecord::Migration
  def change
    rename_column :interviews, :date, :datetime
  end
end
