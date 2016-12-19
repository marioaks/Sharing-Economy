require 'test_helper'

class CityTest < Minitest::Test

	def setup
		@cityValid = City.create(name: "CityValid", lat: -25.34, lng: 5.22)
		@cityOne = City.create(name: "CityOne", lat: 0, lng: 0)
		@cityTwo = City.create(name: "CityTwo", lat: -10, lng: 10.12)
		@cityThree = City.create(name: "CityThree", lat: 10, lng: 10.43)
		@cityFour = City.create(name: "CityFour", lat: 0, lng: 6.234)

		@countryOne = Country.create(name: "CountryOne", world110_id: 4)
		@countryTwo = Country.create(name: "CountryTwo", world110_id: 6)
		@countryThree = Country.create(name: "CountryThree", world110_id: 8)

		@serviceOne = Service.create(name: "ServiceOne", website: "www.abc.com", 
			description: "First Service Site", founded: 1955, topic: "Home")
		@serviceTwo = Service.create(name: "ServiceTwo", website: "www.def.com", 
			description: "Second Service Site", founded: 1965, topic: "Transport")
	end


  def test_City_create_is_valid
    assert @cityOne.valid?, 'City was not valid'
  end

  def test_Country_contains_many_cities
		@countryOne.cities << @cityOne
		@countryOne.cities << @cityTwo

  		assert_equal 2, @countryOne.cities.size
  end

  def test_City_contains_one_country
		@countryTwo.cities << @cityThree
		assert_equal @cityThree.country_id, @countryTwo.id
  end

  def test_Service_contains_one_city_but_city_contains_many_services
    	@countryThree.cities << @cityFour
  		@cityFour.services << @serviceOne
  		@cityFour.services << @serviceTwo

  		assert_equal 2, @cityFour.services.size
  		assert_equal @serviceOne.city, @cityFour
  		assert_equal @serviceTwo.city, @cityFour

  end

  def test_Service_cannot_have_more_than_one_city
  		@cityFour.services << @serviceOne
  		@cityThree.services << @serviceOne

  		assert_equal @serviceOne.city, @cityThree
  end



end
