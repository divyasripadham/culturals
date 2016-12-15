require 'csv'

puts Dir.pwd

CSV.foreach("db/output.csv", { :col_sep => "|", :headers => true }) do |row|
  Event.create!(row.to_h)
end

puts "Seed finished"
puts "#{Event.count} events created"
