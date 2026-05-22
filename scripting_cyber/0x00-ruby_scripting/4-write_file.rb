require 'json'

def merge_json_files(file1_path, file2_path)
  file1 = File.read(file1_path)
  file2 = File.read(file2_path)
  
  data1 = JSON.parse(file1)
  data2 = JSON.parse(file2)
  
  merged_data = data2 + data1
  
  File.write(file2_path, JSON.pretty_generate(merged_data))
  
  puts "Merged JSON written to #{file2_path}"
end
