class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.datetime :date
      t.belongs_to :posting, index: true
      t.string :interviewer
      t.text :notes
      t.string :contact_method

      t.timestamps
    end
  end
end
