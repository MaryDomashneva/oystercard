require 'oystercard'

describe Journey do
  context 'when new' do
    it 'has initial entry station set to nil' do
      entry_station = nil
      journey = Journey.new(nil)
      expect(journey.entry_station).to eq(nil)
    end
    it 'has initial exit station set to nil' do
      exit_station = nil
      journey = Journey.new(nil)
      expect(journey.exit_station).to eq(nil)
    end
  end
end
