json.array!(@interviews) do |interview|
  json.extract! interview, :id, :date, :posting_id, :interviewer, :notes, :contact_method
  json.url interview_url(interview, format: :json)
end
