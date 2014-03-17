class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.date :dateSent
      t.text :coverLetter
      t.references :posting, index: true

      t.timestamps
    end
  end
end
