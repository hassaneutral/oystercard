require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

    let(:min_fare){described_class::MIN_FARE}
    let(:min_balance){described_class::MIN_BALANCE}


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
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end

    it 'reports when oystercard is not in use' do
      allow(oystercard).to receive(:balance) { 2 }
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end

    it 'reports initialized oystercard not in use' do
      expect(oystercard.in_journey?).to eq false
    end

  end


  describe '#touch_in' do
    it "does not let through a card with a balance lesser than the minimum balance " do
      expect{oystercard.touch_in}.to raise_error('Insufficient balance.')
    end
  end

  describe '#touch_out' do
    it "deducts fare when touching out" do
      oystercard.top_up(min_balance)
      oystercard.touch_in
      expect{oystercard.touch_out}.to change{oystercard.balance}.by -min_fare
    end
  end
end

