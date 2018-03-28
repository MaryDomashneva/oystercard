require 'oystercard'

describe Journey do
  context 'when newly initialized' do
    let(:station) { double :station }

    it { expect(subject).to respond_to :complete? }

    it 'returns true if entry&exit station exists' do
      subject.exit_station = station
      subject.entry_station = station
      expect(subject.complete?).to eq(true)
    end

    it 'returns false if exit station does not exist' do
      subject.exit_station = nil
      expect(subject.complete?).to eq(false)
    end

    it 'has initial entry station set to nil' do
      journey = Journey.new(nil)
      expect(journey.entry_station).to eq(nil)
    end
    it 'has initial exit station set to nil' do
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
