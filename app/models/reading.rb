class Reading < ApplicationRecord
  belongs_to :thermostat

  validates :temperature, presence: true
  validates :humidity, presence: true
  validates :battery_recharge, presence: true

  STATS = %w(avg_temperature avg_humidity avg_battery_recharge max_temperature 
            min_temperature max_humidity min_humidity max_battery_recharge min_battery_recharge)

  self.class.class_eval do
    def thermostat(thermostat_id)
      group('thermostat_id').having("thermostat_id = ?", thermostat_id)
    end

    def average_for(thermostat_id)
      where(thermostat_id: thermostat_id)
    end

    ["temperature", "humidity", "battery_recharge"].each do |method|
      define_method "avg_#{method}" do |thermostat_id|
        average_for(thermostat_id).average(method.to_sym)       
      end

      define_method "max_#{method}" do |thermostat_id|
        thermostat(thermostat_id).maximum(method.to_sym)
      end

      define_method "min_#{method}" do |thermostat_id|
        thermostat(thermostat_id).minimum(method.to_sym)
      end
    end

    private 
    def method_missing(method, *args, &block)
      puts "Sorry #{method} does not exist"
    end
  end
end
