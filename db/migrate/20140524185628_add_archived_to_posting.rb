class AddArchivedToPosting < ActiveRecord::Migration
  def change
    add_column :postings, :archived, :boolean, default: false

    add_index :postings, :archived
  end
end
