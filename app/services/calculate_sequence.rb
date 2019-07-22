class CalculateSequence
  attr_reader :tracker

  def initialize(thermostat_tracker)
    @tracker = thermostat_tracker
  end

  def get_tracking_number 
    @max_tracking_number = tracker.max_tracking_number_household || 0
    @max_tracking_number += 1
  end
end