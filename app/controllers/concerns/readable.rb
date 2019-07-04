module Readable
  extend ActiveSupport::Concern

  def thermostats
    puts "===== In Thermostats ====="
    puts @household_token.inspect
    thermostats = Thermostat.where("household_token = ?", @household_token).pluck('id')
    puts thermostats.inspect
    return thermostats
  end

  def track_reading(tracking_number)
    puts "====== In track record ======="
    puts thermostats.inspect
    puts tracking_number.inspect
    Reading.find_by('tracking_number = ? and thermostat_id IN (?)', tracking_number, thermostats)
  end

  def max_tracking_number
    puts "==== In max_tracking_number==="
    tracking_numbers = Reading.where('thermostat_id IN (?)',thermostats).pluck('tracking_number')
    puts thermostats.inspect
    puts tracking_numbers.inspect
    tracking_numbers.compact.max
  end

end