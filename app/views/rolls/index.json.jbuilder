json.array!(@rolls) do |roll|
  json.extract! roll, :id, :name, :state, :current, :size, :user_id
  json.url roll_url(roll, format: :json)
end
