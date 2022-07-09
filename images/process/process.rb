#!/usr/bin/env ruby

require 'active_record'
require 'csv'
require './place'
require './person'

ActiveRecord::Base.establish_connection(
  adapter: :mysql2,
  host: :database,
  username: :codetest,
  password: :swordfish,
  database: :codetest,
)

Person.destroy_all
Place.destroy_all

CSV.read('/data/places.csv', headers: true).map(&:to_h).each do |row|
  Place.create(row)
end

CSV.read('/data/people.csv', headers: true).map(&:to_h).each do |row|
  person = Person.create(row)
  person.place_id = Place.find_by(city: person.place_of_birth).id
  person.save!
end

json_data = Person.all.map(&:place).group_by(&:country).transform_values(&:count)
File.write('/data/output.json', json_data)
