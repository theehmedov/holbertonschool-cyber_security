require 'net/http'
require 'json'

def get_request(url)
  uri = URI(url)
  response = Net::HTTP.get_response(uri)
  
  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  
  body = JSON.parse(response.body)
  puts JSON.pretty_generate(body)
end
