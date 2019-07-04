class CreateReadingWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(thermostat_id, household_token, reading_params = {})
    reading_params = eval(reading_params)
    reading = Reading.create(reading_params.merge(thermostat_id: thermostat_id))  
    if !reading.blank? && !household_token.blank?
      TrackingNumberWorker.perform_async(reading.id, household_token)   
    end
  end
end
