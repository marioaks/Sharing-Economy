
Given(/^I'm on the homepage$/) do
  visit root_path
end

Given(/^I'm on the about page$/) do
  visit '/pages/about/'
end

Given(/^I'm on the contact page$/) do
  visit '/pages/contact/'
end

Given(/^I'm on the country page$/) do
  visit '/countries/new/'
end

Given(/^I'm on the service page$/) do
  visit '/services/new/'
end

Given(/^I'm on a service page$/) do
  visit '/services/1/'
end

Given(/^I'm on a country page$/) do
  visit '/countries/55/'
end

When(/^I move to its services route$/) do
  visit '/countries/55/services/'
end

Then(/^I should see its listed services$/) do
  expect(page).to have_content('APPARTOO')
end

Then(/^I should see its listed countries$/) do
  expect(page).to have_content('France')
end

When(/^I move to its countries route$/) do
  visit '/services/1/countries'
end

Given(/^I'm on the Ride Sharing page$/) do
  visit '/services?topic=Transport'
end

Given(/^I'm on the House Sharing page$/) do
  visit '/services?topic=Home'
end

Then(/^I should see Home Services$/) do
  page.should_not have_content('Transport')
  expect(page).to have_content('Home')end

Then(/^I should see Transport Services$/) do
  page.should_not have_content('Home')
  expect(page).to have_content('Transport')end

When(/^I try to add a new country$/) do
  fill_in 'Name', :with => "Uruguay"
  fill_in 'World110', :with => "10"
  click_button 'Create Country'
end

Then(/^I should see the Service on the Country page$/) do
  visit '/countries/55/'
  expect(page).to have_content('APPARTOO')
end

Then(/^I should see the Country on the Service page$/) do
  visit '/services/1/'
  expect(page).to have_content('France')
end

When(/^I try to add a new service$/) do
  fill_in 'Name', :with => "ServiceA"
  fill_in 'Website', :with => "www.serviceA.com"
  fill_in 'Description', :with => "ServiceA"
  fill_in 'City', :with => "cityA"
  fill_in 'Founded', :with => 1234
  fill_in 'Topic', :with => "Home"
  click_button 'Create Service'
end

#When(/^I try to add a new service with multiple countries$/), :js => true do
#  fill_in 'Name', :with => "ServiceMultiple"
#  fill_in 'Website', :with => "www.serviceMultiple.com"
#  fill_in 'Description', :with => "ServiceMultiple"
#  fill_in 'City', :with => "cityMultiple"
#  select_from_chosen('Afghanistan', 'countries')
#  fill_in 'Founded', :with => 1234
#  fill_in 'Topic', :with => "Home"
#  click_button 'Create Service'
#end


When(/^I try to add a new listing$/) do
  visit '/services/new/'
  fill_in 'Name', :with => "ServiceA"
  fill_in 'Servicetype', :with => "Ride Sharing"
  fill_in 'Website', :with => "www.serviceA.com"
  click_button 'Create Service'

  visit '/countries/new/'
  fill_in 'Name', :with => "Uruguay"
  fill_in 'World110', :with => "10"
  click_button 'Create Country'

  visit '/listings/new/'
  fill_in 'Service', :with => 1
  fill_in 'Country', :with => 1
  fill_in 'Title', :with => "ListingZ"
  fill_in 'Owner', :with => "Dude"
  fill_in 'Latitude', :with => 12
  fill_in 'Longitude', :with => -120
  click_button 'Create Listing'
end

When(/^I try to add a new listing without a country$/) do
  fill_in 'Service', :with => 1
  fill_in 'Country', :with => ""
  fill_in 'Title', :with => "ListingA"
  fill_in 'Owner', :with => "Dude"
  fill_in 'Latitude', :with => 12
  fill_in 'Longitude', :with => -120
  click_button 'Create Listing'
end

Then(/^I should be able to see the new country's page$/) do
  expect(page).to have_content('Country was successfully created.')
end

Then(/^I should be able to see the new service's page$/) do
expect(page).to have_content('Service was successfully created.')end

Then(/^I should be able to see the new listing's page$/) do
expect(page).to have_content('Listing was successfully created.')end

Then(/^I should see a blank country error$/) do
  expect(page).to have_content("Country can't be blank")
end


Then(/^I should see an element "([^"]+)"$/) do |selector|
	find(selector)
    #page.should has_html('div#graph1 svg')
end

Then(/^a tooltip element should exist$/) do
  expect(page).to have_css("#tooltip")
    #page.should has_html('div#graph1 svg')
end

When (/^I reload the page$/) do
	visit [ current_path, page.driver.request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
  #page.evaluate_script("window.location.reload()");
end

Then (/^the (.*) icon loads$/) do |img|
	element = find(".icon-" + img)
	src = element[:src]
	visit src
	page.status_code.should be 200
end

#def select_from_chosen(item_text, options)
#  field = page.find_by_id(options)
#  option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
#  page.execute_script("value = ['#{option_value}']\; if ($('##{field[:id]}').val()) {$.merge(value, $('##{field[:id]}').val())}")
#  option_value = page.evaluate_script("value")
#  page.execute_script("$('##{field[:id]}').val(#{option_value})")
#  page.execute_script("$('##{field[:id]}').trigger('liszt:updated').trigger('change')")
#end

#Then(/^Visualization (\d+) should be visible$/) do |arg1|
 # pending # Write code here that turns the phrase above into concrete actions
#end

