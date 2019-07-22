class TrackingNumberWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform(reading_id, household_token)
    reading = Reading.find_by(id: reading_id)
    unless reading.blank?
      # max_tracking_number = ThermostatTracker.new(household_token: household_token).max_tracking_number_household
      tracking_number = CalculateSequence.new(ThermostatTracker.new(household_token: household_token)).get_tracking_number
      reading.update_column(:tracking_number, tracking_number)       
    end
  end
end