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


csv_text = File.read(Rails.root.join('lib', 'seeds', 'silk_data.csv'), :encoding => 'ISO-8859-1')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
	row['country'].split(',').each do |country|
		country.strip!
		c = Country.find_by name: country
		if country == "Korea"
			c = Country.find_by name: "Korea, Democratic People's Republic of"
		elsif country == "Russia"
			c = Country.find_by name: "Russian Federation"
		elsif country == "The Netherlands"
			c = Country.find_by name: "Netherlands"
		end

		if country != "Singapore"
			c.services.create(name: row['name'], description: row['description'], website: row['website'], city: row['city'], founded: row['founded'], topic: row['topic'])
	  	end
	 end



  	#s = Service.new
  #s.name = row['name']
  #s.website = row['website']
  
  #arr = []
  #arr << c
  #s.countries = arr
  #s.city = City.where("name = " + row['city'])
  #s.founded = row['founded']
  #s.topic = row['topic']
  #puts s.name
end

#Country.create(name: 'France', world110_id: 1)
#Service.create(name: 'BlaBlaCar', serviceType: 'Ride Sharing', website: 'http://blablaCar.com')