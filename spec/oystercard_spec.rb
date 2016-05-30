require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

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

  describe '#deduct' do
  	
  	it 'deducts money from oystercard' do
  		expect{oystercard.deduct(1)}.to change{oystercard.balance}.by -1
  	end

  end

end