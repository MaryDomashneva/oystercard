require 'oystercard'

describe Journey do
  context 'when new' do
    let(:station) { double :station }

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

    context 'when set entry station' do
      it 'saves entry station' do
        subject.entry_station = station
        expect(subject.entry_station).to eq(station)
      end
    end

    context 'when set exit station' do
      it 'saves exit station' do
        subject.exit_station = station
        expect(subject.exit_station).to eq(station)
      end
    end
  end
end
