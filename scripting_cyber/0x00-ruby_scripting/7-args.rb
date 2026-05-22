def print_arguments
  if ARGV.empty?
    puts "No arguments provided."
  else
    args_str = ARGV.map.with_index { |arg, i| "#{i + 1}. #{arg}" }.join(", ")
    puts "Arguments: #{args_str}"
  end
end
