class AddFollowUpCheck < ActiveRecord::Migration
  def change
    add_column :job_applications, :followup, :datetime, default: nil
  end
end
