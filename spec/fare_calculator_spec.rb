require 'oystercard'

describe FareCalculator do
  MINIMUM_FAIR = 1
  BOUNDARY_CROSSED_1_2 = 2
  BOUNDARY_CROSSED_3_5 = 3

  context 'when initialized' do
    it { expect(subject).to respond_to :calculator}
    it { expect(subject).to respond_to(:cross_border).with(1).argument }

    let(:station_1) { double :station }
    let(:station_2) { double :station }
    let(:journey) { double :journey }
    let(:card) { double :oystercard }

    context 'when calculate a fare charge' do
      before {
        allow(journey).to receive(:entry_station).and_return(station_1)
        allow(journey).to receive(:exit_station).and_return(station_2)
      }
      
      context 'when inside zone 1' do
        context 'when the journey is comlete' do
          before {
            allow(journey).to receive(:complete?).and_return(true)
            allow(station_1).to receive(:zone).and_return(1)
            allow(station_2).to receive(:zone).and_return(1)
          }

          it 'uses minimum fair' do
            subject.cross_border(journey)
            expect(subject.calculator(journey)).to eq(1)
          end
        end
        context 'when the journey is not complete' do
          before {
            allow(journey).to receive(:complete?).and_return(false)
          }

          it 'charges penalty' do
            expect(subject.calculator(journey)).to eq(7)
          end
        end
      end
    end
  end
end
