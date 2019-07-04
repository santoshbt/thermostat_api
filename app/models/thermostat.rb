class Thermostat < ApplicationRecord
  validates :household_token, presence: true
  validates :location, presence: true
  has_many :readings
end
