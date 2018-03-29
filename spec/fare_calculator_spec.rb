require 'oystercard'

describe FareCalculator do
  context 'when initialized' do
    it { expect(subject).to respond_to(:calculator).with(1).argument }
    it { expect(subject).to respond_to(:cross_border).with(1).argument }
    let(:station_1) { double :station }
    let(:station_2) { double :station }
    let(:journey) { double :journey }
    let(:card) { double :oystercard }
    context 'when calculate a fare charge' do
      before do
        allow(journey).to receive(:entry_station).and_return(station_1)
        allow(journey).to receive(:exit_station).and_return(station_2)
      end
      context 'when inside zone 1' do
        context 'when the journey is comlete' do
          before do
            allow(journey).to receive(:complete?).and_return(true)
            allow(station_1).to receive(:zone).and_return(1)
            allow(station_2).to receive(:zone).and_return(1)
          end
          it 'uses minimum fair' do
            subject.cross_border(journey)
            expect(subject.calculator(journey)).to eq(1)
          end
        end
        context 'when the journey is not complete' do
          before do
            allow(journey).to receive(:complete?).and_return(false)
          end
          it 'charges penalty' do
            expect(subject.calculator(journey)).to eq(7)
          end
        end
      end
    end
  end
end
