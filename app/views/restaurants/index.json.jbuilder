json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :contact, :location, :verified, :photos, :latitude, :longitude
  json.url restaurant_url(restaurant, format: :json)
end
