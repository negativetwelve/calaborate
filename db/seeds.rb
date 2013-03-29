# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

csv = {}
counter = 0
CSV.foreach("public/classes.csv") do |row|
  csv[counter] = row
  counter = counter + 1
end

csv[0].each_with_index do |full_name, index|
  puts full_name
  c = Course.create(name: full_name.to_s, abbr: csv[1][index].to_s, short_code: full_name.gsub(" AND", "").scan(/(\A|\W)(\w)/).collect{|s| s[1]}.join.upcase.gsub(/[^a-zA-Z]/, ''))
end
