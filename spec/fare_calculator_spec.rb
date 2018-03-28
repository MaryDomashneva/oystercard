require 'oystercard'

describe FareCalculator do
  MINIMUM_FAIR = 1
  BOUNDARY_CROSSED_1_2 = 2
  BOUNDARY_CROSSED_3_5 = 3

  context 'when initialized' do
    it { expect(subject).to respond_to :calculator}
    let(:station) { double :station }
    let(:journey) { double :journey }
    let(:card) { double :oystercard }

    context 'when calculate a fare charge' do
      context 'when inside zone 1' do
        context 'when the journey is comlete' do
          before {
            allow(journey).to receive(:complete?).and_return(true)
          }

          it 'uses minimum fair' do
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
