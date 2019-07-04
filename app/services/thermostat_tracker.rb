class ThermostatTracker
  attr_reader :household_token, :thermostat_id, :thermostat_token, :tracking_number

  def initialize(household_token: nil, thermostat_id: nil, thermostat_token: nil, tracking_number: nil)
    @household_token = household_token
    @thermostat_id = thermostat_id
    @thermostat_token = thermostat_token
    @tracking_number = tracking_number
  end

  def max_tracking_number_household
    tracking_numbers = Reading.where('thermostat_id IN (?)',thermostats).pluck('tracking_number')
    tracking_numbers.compact.max
  end

  def thermostats
    thermostats = Thermostat.where("household_token = ?", household_token).pluck('id')
    return thermostats
  end

  def max_tracking_number_thermostat
    tracking_numbers = Reading.where("thermostat_id = ?", thermostat_id).pluck('tracking_number')
    tracking_numbers.compact.max || 0
  end

  def track_reading   
    Reading.find_by('tracking_number = ? and thermostat_id IN (?)', tracking_number, thermostats)
  end
end