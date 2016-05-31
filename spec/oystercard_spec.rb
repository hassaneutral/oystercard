require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  let(:station){double(:station)}
  let(:station2){double(:station)}
  let(:min_fare){described_class::MIN_FARE}
  let(:min_balance){described_class::MIN_BALANCE}
  let(:journey){{entry_station: station, exit_station: station2}}

  describe '#Initialize' do
    it 'has an empty list of journeys by default' do
      expect(oystercard.journey_log).to eq []
    end
  end

  describe '#balance' do

    it 'allows user to see starting balance of zero' do
      expect(oystercard.balance).to eq 0
    end

  end

  describe '#top_up' do

  	it 'tops up oystercard' do
  		expect{oystercard.top_up(1)}.to change{oystercard.balance}.by 1
  	end

    it 'raises an error if balance exceeds max limit' do
      oystercard.top_up(Oystercard::MAX_LIMIT)
      expect{oystercard.top_up(1)}.to raise_error "Balance can not exceed £#{Oystercard::MAX_LIMIT}"
    end

  end


  describe '#in_journey?' do
    it 'reports when oystercard is in use' do
      allow(oystercard).to receive(:balance) { 2 }
      oystercard.touch_in(station)
      expect(oystercard.in_journey?).to eq true
    end

    it 'reports when oystercard is not in use' do
      allow(oystercard).to receive(:balance) { 2 }
      oystercard.touch_in(station)
      oystercard.touch_out(station2)
      expect(oystercard.in_journey?).to eq false
    end

    it 'reports initialized oystercard not in use' do
      expect(oystercard.in_journey?).to eq false
    end

  end


  describe '#touch_in' do
    it "does not let through a card with a balance lesser than the minimum balance " do
      expect{oystercard.touch_in(station)}.to raise_error('Insufficient balance.')
    end
  end


  describe '#touch_out' do
    it "deducts fare when touching out" do
      oystercard.top_up(min_balance)
      oystercard.touch_in(station)
      expect{oystercard.touch_out(station2)}.to change{oystercard.balance}.by -min_fare
    end

    it "records current journey" do
      oystercard.top_up(min_balance)
      oystercard.touch_in(station)
      oystercard.touch_out(station2)
      oystercard.journey_log.last.should include(journey)
    end

  end
end

