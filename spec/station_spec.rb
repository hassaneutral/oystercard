describe Station do

  subject(:station) {described_class.new(:name,:zone)}

  describe '#zone' do
    it "allows to set the station's zone" do
      station2 = Station.new("Station 2",2)
      expect(station2.zone).to eq 2
    end
  end

  describe '#name' do
    it "allows to set the station's name" do
      station2 = Station.new("Station 2",2)
      expect(station2.name).to eq "Station 2"
    end
  end

end
