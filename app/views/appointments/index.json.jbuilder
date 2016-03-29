json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :date, :pet_id, :user_id
  json.url appointment_url(appointment, format: :json)
end
