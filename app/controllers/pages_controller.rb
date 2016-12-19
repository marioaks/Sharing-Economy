class PagesController < ApplicationController

  def home
  	@services = Service.all

  	@topics = Hash.new(0)

  	@services.each do |service|
  		@topics[service.topic] += 1
  	end

  	@chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:chart][:height] = 400
      f.options[:legend][:enabled] = false
      f.options[:xAxis][:type] = 'category'
      f.options[:xAxis][:labels] = {:rotation=> -45, :style=>{:fontSize=> '9.5px', :fontFamily=>'Verdana, sans-serif'}}

      f.labels(:items=>[:html=>"# of services", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])

	  otherSum = 0

	  data = [{:name=>'Home Sharing', :y=>@topics['Home'], :color=> '#c390D4'}, 
	  	{:name=>'Ride Sharing', :y=>@topics['Transport'], :color=> '#90c3d4'}]

      @topics.each do |key, value|
      	dataToAdd = {}
      	k = key.to_s
      	if (k != "Home" && k != "Transport")
      		dataToAdd = {:name=>k, :y=>value, :color=> '#d4a190'}
      		otherSum += value
      		data << dataToAdd
		end
      end

      f.series(:type=> 'column', :name => "Services", :data=> data)

      f.series(:type=> 'pie',:name=> 'Total Services', 
        :data=> [
          {:name=> 'Home Sharing', :y=> @topics["Home"], :color=> '#c390D4'}, 
          {:name=> 'Ride Sharing', :y=> @topics["Transport"] ,:color=> '#90c3d4'},
          {:name=> 'Other', :y=> otherSum,:color=> '#d4a190'}
        ],
        :center=> [700, 80], :size=> 120, :showInLegend=> false)
    end
  end

end