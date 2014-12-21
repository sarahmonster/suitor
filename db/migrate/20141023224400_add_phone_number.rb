class AddPhoneNumber < ActiveRecord::Migration
  def change
    add_column :postings, :contact_number, :string
  end
end
