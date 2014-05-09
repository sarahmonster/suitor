json.extract! @job_application, :id, :date_sent, :cover_letter, :posting_id, :created_at, :updated_at

if @job_application_is_new
  json.html render("dialog.html")
  json.replacementHTML render("replacement_checkmark.html")
end
