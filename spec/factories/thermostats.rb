FactoryBot.define do
  factory :thermostat do
    household_token {"1cyed7l2dd"}
    location {"Suite 971 905 Rohan Square, East Olindamouth, AL 48907-6959"}
  end

  factory :thermostat_1, class: Thermostat do
    household_token {"1cyed7l2dd"}
    location {"Suite 971 905 Rohan Square, East Olindamouth, AL 48907-6959"}
  end

  factory :thermostat_2, class: Thermostat do
    household_token {"11sqjbee8b"}
    location {"6948 Stark Circles, Hauckview, DE 35918-2431"}
  end

  factory :thermostat_3, class: Thermostat do
    household_token {"11sqjbee8b"}
    location {"6948 Stark Circles, Hauckview, DE 35918-2431"}
  end
end