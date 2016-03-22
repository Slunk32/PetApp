json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :breed, :size, :age, :personality
  json.url pet_url(pet, format: :json)
end
