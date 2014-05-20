class AddMoreUsefulApplicationInformation < ActiveRecord::Migration
  def change
    remove_column :postings, :submission_requirements, :string
    add_column :postings, :deadline, :date
    add_column :postings, :application_instructions, :text
  end
end
