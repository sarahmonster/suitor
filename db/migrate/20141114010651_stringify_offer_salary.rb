class StringifyOfferSalary < ActiveRecord::Migration
  def change
    change_column :offers, :salary, :string
  end
end
