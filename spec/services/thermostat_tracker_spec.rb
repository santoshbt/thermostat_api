require 'rails_helper'

RSpec.describe ThermostatTracker do
  before(:all) do
    FactoryBot.create(:thermostat)
    FactoryBot.create(:thermostat_1)
    FactoryBot.create(:thermostat_2)
    FactoryBot.create(:thermostat_3)
  end

  describe '#thermostats' do
    let(:household_token) {'11sqjbee8b'}
    subject { described_class.new(household_token: household_token) }

    it 'returns the thermostats belonging to household' do
      expect(subject.thermostats.size).to eq(2)
    end
  end

  context "Get the thremostat tracking number from Reading" do
    before(:each) do     
      FactoryBot.create(:reading)
    end
    
    describe '#max_tracking_number_household' do   
      let(:household_token) {'1cyed7l2dd'}      
      subject { described_class.new(household_token: household_token) }

      it 'returns the recent token number of household' do            
        expect(subject.max_tracking_number_household).to eq(1)
      end
    end

    describe '#max_tracking_number_thermostat' do    
      let(:thermostat_id) {1}
      subject { described_class.new(thermostat_id: thermostat_id) }

      it 'returns the recent tracking number for a particular thermostat' do
        expect(subject.max_tracking_number_thermostat).to eq(1)
      end
    end

    describe '#track_reading' do    
      let(:household_token) {'1cyed7l2dd'}
      subject { described_class.new(household_token: household_token, tracking_number: 1) }

      it 'returns the recent tracking number for a particular thermostat' do
        expect(subject.track_reading.temperature).to eq(26.9)
        expect(subject.track_reading.humidity).to eq(15.44)
        expect(subject.track_reading.battery_recharge).to eq(24.4)      
      end
    end
  end
end