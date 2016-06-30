require 'random_data'

50.times do
  College.create!(
    name: RandomData.random_sentence,
    address1: RandomData.random_sentence,
    city: RandomData.random_sentence,
    state: RandomData.random_sentence
  )
end
colleges = College.all

100.times do
  Event.create!(
    college: colleges.sample,
    name: RandomData.random_sentence,
    startdate: RandomData.random_date_start,
    enddate: RandomData.random_date_end,
    url: "http://www.iirdem.org/july-icrder-coim-2016.html",
    event_type: RandomData.random_integer
  )
end
events = Event.all

150.times do
  Video.create!(
    event: events.sample,
    title: RandomData.random_sentence,
    url: "https://youtu.be/t_e24rP03mI"
  )
end

puts "Seed finished"
puts "#{College.count} colleges created"
puts "#{Event.count} events created"
puts "#{Video.count} videos created"
