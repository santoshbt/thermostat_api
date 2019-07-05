require 'rails_helper'

RSpec.describe CalculateSequence do
  describe '#get_tracking_number' do
    let(:max_tracking_number) {1}
    subject { described_class.new(max_tracking_number) }

    it 'returns the thermostats belonging to household' do
      expect(subject.get_tracking_number).to eq(2)
    end
  end
end