FactoryBot.define do
  factory :reading do
    temperature {"26.9"}
    humidity {"15.44"}
    battery_recharge {"24.4"}
    thermostat_id {"1"}
    tracking_number {1}
  end

  factory :reading_1, class: Reading do
    temperature {"23.9"}
    humidity {"10.44"}
    battery_recharge {"18.4"}
    thermostat_id {"1"}
    tracking_number {2}
  end
end

