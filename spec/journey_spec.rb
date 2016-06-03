require 'journey'

describe Journey do

  subject(:journey) { described_class.new(station1) }

  let(:station1) { double(:station, :zone => 5) }
  let(:station2) { double(:station, :zone => 2) }
  let(:min_fare) { described_class::MIN_FARE}
  let(:penalty_fare) { described_class::PENALTY_FARE }

  it 'will be initialized with a new entry station' do
    expect(journey.entry_station).to eq(station1)
  end
  
  describe '#set_exit' do
    it '#set_exit stores the exit station' do
      expect{journey.set_exit(station1)}.to change{journey.exit_station}.to (station1)
    end
  end

  describe '#fare' do
    it 'returns the penalty fare' do
      expect(journey.fare).to eq(penalty_fare)
    end

    it 'returns the minimum fare if journey is valid' do
      journey.set_exit(station1)
      expect(journey.fare).to eq(min_fare)
    end

    it 'returns the correct fare for a journey between different zones' do
      journey.set_exit(station2)
      expect(journey.fare).to eq(4)
    end
  end

end
