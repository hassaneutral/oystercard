require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe '#balance' do

    it 'allows user to see starting balance' do
      expect(oystercard.balance).to eq 0
    end

  end

  describe '#top_up' do

  	it 'responds to method with 1 argument' do
  		expect(oystercard).to respond_to(:top_up).with(1).argument
  	end
  	it 'tops up oystercard' do
  		expect(oystercard.top_up(1)).to eq 1
  	end
  	it 'tops up oystercard with non-zero balance' do
  		oystercard.top_up(1)
  		expect(oystercard.top_up(2)).to eq 3
  	end
    it 'raises an error if balance exceeds max limit' do
      oystercard.top_up(Oystercard::MAX_LIMIT)
      expect{oystercard.top_up(1)}.to raise_error "Balance can not exceed £#{Oystercard::MAX_LIMIT}"
    end


  end

end