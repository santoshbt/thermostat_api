class ThermostatTracker
  attr_reader :household_token, :thermostat_id, :thermostat_token, :tracking_number

  def initialize(args)
    @household_token = args[:household_token]
    @thermostat_id = args[:thermostat_id]
    @thermostat_token = args[:thermostat_token]
    @tracking_number = args[:tracking_number]
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