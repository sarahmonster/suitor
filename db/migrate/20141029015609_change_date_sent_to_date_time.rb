class ChangeDateSentToDateTime < ActiveRecord::Migration
  def up
    change_column :job_applications, :date_sent, :datetime

    JobApplication.all.each do |j|
      j.date_sent = j.date_sent.to_datetime
      puts j.date_sent.to_datetime
      j.save(validate: false)
    end
  end

  def down
    change_column :job_applications, :date_sent, :date

    JobApplication.all.each do |j|
      j.date_sent = j.date_sent.to_date
      j.save(validate: false)
    end
  end
end
