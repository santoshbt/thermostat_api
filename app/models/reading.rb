class Reading < ApplicationRecord
  belongs_to :thermostat, dependent: :destroy
  STATS = %w(avg_temperature avg_humidity avg_battery_recharge max_temperature 
            min_temperature max_humidity min_humidity max_battery_recharge min_battery_recharge)

  Reading.singleton_class.class_eval do
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
  end
end
