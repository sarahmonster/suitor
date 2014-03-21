class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.date :date_sent
      t.text :cover_letter
      t.references :posting, index: true

      t.timestamps
    end
  end
end
