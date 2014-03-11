class AddDetailsToPostings < ActiveRecord::Migration
  def change
    add_column :postings, :url, :string
    add_column :postings, :datePosted, :date
    add_column :postings, :jobLocation, :string
    add_column :postings, :hiringOrganization, :string
    add_column :postings, :hiringOrganizationUrl, :string
    add_column :postings, :contactName, :string
    add_column :postings, :contactEmail, :string
    add_column :postings, :applicationUrl, :string
    add_column :postings, :submissionRequirements, :string
  end
end
