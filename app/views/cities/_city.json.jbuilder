json.extract! city, :id, :name, :lat, :lng, :country_id, :created_at, :updated_at
json.url city_url(city, format: :json)