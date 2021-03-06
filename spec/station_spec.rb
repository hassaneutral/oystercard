require 'station'

describe Station do

  subject(:station) { described_class.new("Bank",1) }

  context 'initialization'do
    
    it 'checks that name is initialized' do
      expect(station.name).to eq("Bank")
    end

    it 'checks that zone is initialized' do
      expect(station.zone).to eq(1)
    end
  end
  
end
