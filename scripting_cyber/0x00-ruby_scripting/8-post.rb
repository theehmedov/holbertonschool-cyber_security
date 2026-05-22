require 'net/http'
require 'json'

def post_request(url, body_params)
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if uri.scheme == 'https'
  
  request = Net::HTTP::Post.new(uri.path)
  request['Content-Type'] = 'application/json'
  request.body = JSON.generate(body_params)
  
  response = http.request(request)
  
  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"
  
  body = JSON.parse(response.body)
  if body.empty?
    puts "{}"
  else
    puts JSON.pretty_generate(body)
  end
end
