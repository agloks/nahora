# crest = https://github.com/mamantoha/crest

require "crest"

request = Crest::Request.new(:post,
  "http://httpbin.org/post",
  headers: {"Content-Type" => "application/json"},
  form: {:width => 640, "height" => "480"}.to_json
)
response_object = request.execute

p response_object.body