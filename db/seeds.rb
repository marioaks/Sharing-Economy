# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
require 'tsv'

tsv_text = File.read(Rails.root.join('lib', 'seeds', 'world-110m.tsv'), :encoding => 'ISO-8859-1')
tsv = TSV.parse(tsv_text, :headers => false)
tsv.each do |row|
  Country.create(world110_id: row[0], name: row[1])
end

csv_city_text = File.read(Rails.root.join('lib', 'seeds', 'world_cities.csv'), :encoding => 'ISO-8859-1')
city_csv = CSV.parse(csv_city_text, :headers => true)
city_csv.each do |row|
	city = City.create(name: row[0], lat: row[2].to_s, lng: row[3].to_s)


	country = row['country']
	c = Country.find_by name: row['country']
	c.cities << city
end


csv_text = File.read(Rails.root.join('lib', 'seeds', 'silk_data.csv'), :encoding => 'ISO-8859-1')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|

	cities = City.where name: row['city']
	city = nil

	
	c = Country.find_by name: row['country']
	puts c.name
	if cities.any?
		cities.each do |cityPossible|
			if (c.cities.include? cityPossible)
				city = cityPossible
			end
		end
	end

	
	if city != nil
		service = Service.create(name: row['name'], description: row['description'], website: row['website'], founded: row['founded'], topic: row['topic'], city_id: city.id)
		c.services << service
	else
		service = Service.create(name: row['name'], description: row['description'], website: row['website'], founded: row['founded'], topic: row['topic'])
		c.services << service
	end

end



