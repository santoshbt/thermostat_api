class ReadingsController < ApplicationController
  before_action :initilize_household
  before_action :authenticate_thermostat, only: [:create, :stats]

  def create    
    CreateReadingWorker.perform_async(@thermostat_id, @household_token, reading_params)
    ##### wait to get the real time tracking number to be updated by the background job in database
    sleep(0.5)                          
    tracking_number = ThermostatTracker.new(thermostat_id: @thermostat_id).max_tracking_number_thermostat 
    render json: {tracking_number: tracking_number, status: 200, message: 'Reading created'}
  end

  def show     
    tracking_number = params[:tracking_number].to_i
    reading = ThermostatTracker.new(tracking_number: tracking_number, household_token: @household_token).track_reading

    unless reading.blank?
      render json: {temperature: reading.temperature, 
                    humidity: reading.humidity, 
                    battery_recharge: reading.battery_recharge,
                    status: 200, message: 'Reading found'}
    else
      render json: {status: 422, message: 'unprocessable_entity'}
    end
  end

  def stats
    stats = Reading::STATS
    stats_hash, json_hash = {}, {}
    arr = ['max', 'min']
    begin
      stats.each do |stat|
        stats_hash[stat.to_sym] = Reading.send(stat.to_sym, @thermostat_id)
      end    

      stats.each do |stat|       
        json_hash["#{stat}".to_sym] = stats_hash["#{stat}".to_sym].round(2) if stat.starts_with?('avg')        
        json_hash["#{stat}".to_sym] = stats_hash[stat.to_sym][@thermostat_id] if stat.starts_with?(*arr) 
      end
      
      json_hash.merge!({status: 200, message: "Statistical data"})
      render json: json_hash
    rescue 
      render json: {status: 422, message: 'unprocessable_entity'}
    end
  end

  private

  def initilize_household
    @household_token = params[:reading][:household_token]
  end
  
  def authenticate_thermostat    
    @thermostat_id = params[:reading][:thermostat_id].to_i
    thermostats = ThermostatTracker.new(household_token: @household_token).thermostats
    unless thermostats.include?(@thermostat_id)      
      render json: {status: 422, message: "Thermostat not found in the household #{@household_token}"} and return
    end  
  end
  
  def reading_params
    params.require(:reading).permit(:temperature, :humidity, :battery_recharge)
  end
end
