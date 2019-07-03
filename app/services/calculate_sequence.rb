class CalculateSequence
  attr_reader :max_tracking_number

  def initialize(max_tracking_number)
    @max_tracking_number = max_tracking_number
  end

  def get_tracking_number 
    @max_tracking_number ||= 0   
    @max_tracking_number += 1
  end
end