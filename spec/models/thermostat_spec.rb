require 'rails_helper'

RSpec.describe Thermostat, :type => :model do
  describe "Thermosat creation" do
    it 'creates a thermostat record' do    
      thermostat = FactoryBot.create(:thermostat)  
      expect(thermostat.household_token).to eq("1cyed7l2dd")
      expect(thermostat.location).to eq("Suite 971 905 Rohan Square, East Olindamouth, AL 48907-6959")
    end

    it 'has association with readings' do
      t = Thermostat.reflect_on_association(:readings)
      expect(t.macro).to eq(:has_many)
    end
  end
end