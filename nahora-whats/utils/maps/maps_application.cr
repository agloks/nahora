# google_maps_lib = https://github.com/fridgerator/google_maps_api

require "google_maps_api"

# pp GoogleMapsApi::Geocoding.address_search("1111 North 20th").to_json
# pp GoogleMapsApi::Place.nearby(40.714224, -73.961452, {:radius => 1000})[0..2].to_json
result = GoogleMapsApi::Directions.get(39.6684948, -79.6375071, 40.4313473, -80.0505404).to_json
pp result
File.write("abcde.json", result, mode: "w")