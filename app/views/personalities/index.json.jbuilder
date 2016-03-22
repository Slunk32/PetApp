json.array!(@personalities) do |personality|
  json.extract! personality, :id, :trait, :pet_id
  json.url personality_url(personality, format: :json)
end
