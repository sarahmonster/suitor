json.array!(@offers) do |offer|
  json.extract! offer, :id, :salary, :details, :posting_id
  json.url offer_url(offer, format: :json)
end
