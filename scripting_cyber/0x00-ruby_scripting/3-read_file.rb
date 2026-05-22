require 'json'

def count_user_ids(path)
  file = File.read(path)
  data = JSON.parse(file)
  
  user_count = {}
  
  data.each do |item|
    user_id = item['userId']
    user_count[user_id] = (user_count[user_id] || 0) + 1
  end
  
  user_count.sort.each do |user_id, count|
    puts "#{user_id}: #{count}"
  end
end
