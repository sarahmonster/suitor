class AddDetailsToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :url, :string
    add_column :postings, :date_posted, :date
    add_column :postings, :job_location, :string
    add_column :postings, :hiring_organization, :string
    add_column :postings, :hiring_organization_url, :string
    add_column :postings, :contact_name, :string
    add_column :postings, :contact_email, :string
    add_column :postings, :application_url, :string
    add_column :postings, :submission_requirements, :string
  end
end
