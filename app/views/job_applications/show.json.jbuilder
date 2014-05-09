json.extract! @job_application, :id, :date_sent, :cover_letter, :posting_id, :created_at, :updated_at
json.html render("dialog.html")
json.replacementHTML render("replacement_checkmark.html")
