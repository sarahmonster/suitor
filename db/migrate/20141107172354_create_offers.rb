class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :salary
      t.text :details
      t.references :posting, index: true

      t.timestamps
    end
  end
end
