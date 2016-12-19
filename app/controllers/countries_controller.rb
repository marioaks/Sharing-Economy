class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  # GET /countries
  # GET /countries.json
  def index
    if params[:service_id].nil?
      @countries = Country.all
    else
      @countries = Service.find(params[:service_id]).countries
    end
  end

  # GET /countries/1
  # GET /countries/1.json
  def show
    @country = Country.includes(:services).find(params[:id])

    home = 0
    transport = 0
    other = 0

    @country.services.each do |service|
      topic = service.topic
      if topic == "Home"
        home += 1
      elsif topic == "Transport"
        transport += 1
      else
        other += 1
      end
    end


    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 50, 50, 50], 
        :spacingTop=> 0,
        :spacingBottom=> 0,
        :spacingLeft=> 0,
        :spacingRight=> 0} )
      series = {
               :type=> 'pie',
               :name=> 'Services in ' + @country.name,
               :data=> [
                  {:name=> 'Home Sharing', :y=> home, :color=> '#c390D4'}, 
                  {:name=> 'Ride Sharing', :y=> transport ,:color=> '#90c3d4'},
                  {:name=> 'Other', :y=> other,:color=> '#d4a190'}
               ]
      }
      f.series(series)
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
      f.plotOptions({:pie=>{:size=>'100%'}}) 
      
    end
  end


  # GET /countries/new
  def new
    @country = Country.new
  end

  # GET /countries/1/edit
  #def edit
  #end

  # POST /countries
  # POST /countries.json
  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /countries/1
  # PATCH/PUT /countries/1.json
  
  #def update
  #  respond_to do |format|
  #    if @country.update(country_params)
  #      format.html { redirect_to @country, notice: 'Country was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @country }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @country.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end


  # DELETE /countries/1
  # DELETE /countries/1.json
  #def destroy
  #  @country.destroy
  #  respond_to do |format|
  #    format.html { redirect_to countries_url, notice: 'Country was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      params.require(:country).permit(:name, :world110_id, cities_ids: [], services_ids: [])
    end
end
