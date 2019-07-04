require 'rails_helper'

RSpec.describe ThermostatTracker do
  before do
    DatabaseCleaner.clean 
    FactoryBot.create(:thermostat)
  end
  describe '#max_tracking_number_household' do   
    before do      
      FactoryBot.create(:reading)
    end

    let(:household_token) {'1cyed7l2dd'}
    
    subject { described_class.new(household_token: household_token) }

    it 'outputs the recent token number of household' do            
      expect(subject.max_tracking_number_household).to eq(1)
    end
  end

  describe '#thermostats' do
    before do
      DatabaseCleaner.clean 
      FactoryBot.create(:thermostat_1)
      FactoryBot.create(:thermostat_2)
      FactoryBot.create(:thermostat_3)
    end  
    let(:household_token) {'11sqjbee8b'}

    subject { described_class.new(household_token: household_token) }

    it 'outputs the thermostats belonging to household' do
      expect(subject.thermostats.size).to eq(2)
    end
  end
end