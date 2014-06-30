json.array!(@photos) do |photo|
  json.extract! photo, :id, :image, :roll_id, :latitude, :longitude
  json.url photo_url(photo, format: :json)
end
