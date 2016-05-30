require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe '#balance' do

    it 'allows user to see starting balance' do
      expect(oystercard.balance).to eq 0
    end
  end


end