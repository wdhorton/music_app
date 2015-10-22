# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

8.times do |i|
  Band.create!(name: "Band #{i}")
end

16.times do |i|
  band = Band.all.sample
  Album.create!(title: "#{band.name}'s Album #{i}", band_id: band.id, recorded: ["live", "studio"].sample)
end

40.times do |i|
  album = Album.all.sample
  Track.create!(title: "Track #{i}", album_id: album.id, lyrics: "Na na na", kind: "regular")
end
