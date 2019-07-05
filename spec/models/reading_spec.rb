require 'rails_helper'

RSpec.describe Reading, :type => :model do
  before do
    FactoryBot.create(:thermostat)    
    FactoryBot.create(:reading)    
    FactoryBot.create(:reading_1)   
  end

  let(:thermostat_id) {1} 

  describe 'create thermostat readings' do
    it 'associates with thermostat' do
      t = Reading.reflect_on_association(:thermostat)
      expect(t.macro).to eq(:belongs_to)
    end 
  end

  describe '.avg_temperature' do
    subject { described_class.avg_temperature(thermostat_id) }

    it 'returns average temperature for a particular thermostat' do
      expect(subject).to eq(0.259e2)
    end
  end

  describe '.avg_humidity' do
    subject { described_class.avg_humidity(thermostat_id) }

    it 'returns average humidity for a particular thermostat' do
      expect(subject).to eq(0.137733333333333e2)
    end
  end

  describe '.avg_battery_recharge' do
    subject { described_class.avg_battery_recharge(thermostat_id) }

    it 'returns average battery recharge for a particular thermostat' do
      expect(subject).to eq(0.224e2)
    end
  end

  describe '.max_temperature' do
    subject { described_class.max_temperature(thermostat_id) }

    it 'returns max temperature for a particular thermostat' do
      expect(subject[thermostat_id]).to eq(26.9)
    end
  end

  describe '.min_temperature' do
    subject { described_class.min_temperature(thermostat_id) }

    it 'returns min temperature for a particular thermostat' do
      expect(subject[thermostat_id]).to eq(23.9)
    end
  end

  describe '.max_humidity' do
    subject { described_class.max_humidity(thermostat_id) }

    it 'returns max humidity for a particular thermostat' do
      expect(subject[thermostat_id]).to eq(15.44)
    end
  end

  describe '.min_humidity' do
    subject { described_class.min_humidity(thermostat_id) }

    it 'returns min humidity for a particular thermostat' do
      expect(subject[thermostat_id]).to eq(10.44)
    end
  end

  describe '.max_battery_recharge' do
    subject { described_class.max_battery_recharge(thermostat_id) }

    it 'returns max humidity for a particular thermostat' do
      expect(subject[thermostat_id]).to eq(24.4)
    end
  end

  describe '.min_battery_recharge' do
    subject { described_class.min_battery_recharge(thermostat_id) }

    it 'returns min humidity for a particular thermostat' do
      expect(subject[thermostat_id]).to eq(18.4)
    end
  end
end