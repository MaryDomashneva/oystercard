require 'oystercard'
DEFAULT_CAPACITY = 90
MINIMUM_FAIR = 1
ERROR_MESSAGES = {
  exceeded_limit: 'The amount you are trying to top up is above limit = 90 GBR',
  minimum_fair: 'Minimum amount to start a journey is 1 GBR'
}.freeze

describe Oystercard do
  context 'when initialized responds to methods' do
    it { expect(subject).to respond_to(:touch_in).with(1).argument }
    it { expect(subject).to respond_to :touch_out }
    it { expect(subject).to respond_to :in_journey? }
    it { expect(subject).to respond_to(:top_up).with(1).argument }

    let(:station) { double :station }

    before do
      allow(station).to receive(:pass).and_return(true)
    end

    context 'when initial balance set-up to "0"' do
      it 'uses that balance' do
        balance = 0
        card = Oystercard.new(0)
        expect(card.balance).to eq(balance)
      end

      context 'Oyser card can be top_up' do
        context 'when the amount of top_up fit the default capacity' do
          it 'returns new balance when topped_up' do
            amount = 80
            expect(subject.top_up(amount)).to eq(80)
          end
        end
        context 'when the amount of top_up does not fit the default capacity' do
          it 'raises an error' do
            expect { subject.top_up(100) }.to raise_error(ERROR_MESSAGES[:exceeded_limit])
          end
        end
      end

      context 'Oyster card can be deduct' do
        it 'returns new balance when deduct' do
          amount_top_up = 80
          subject.top_up(amount_top_up)
          amount_deduct = 10
          expect(subject.send(:deduct, amount_deduct)).to eq(70)
        end
      end
    end

    context 'Oyster card can be in a journey' do
      let(:station_1) { double :station }
      let(:station_2) { double :station }
      let(:journey) { double :journey }

      before do
        allow(journey).to receive(:entry_station).and_return(station_1)
        allow(journey).to receive(:exit_station).and_return(station_2)
        allow(station_1).to receive(:zone).and_return(1)
        allow(station_1).to receive(:pass)
        allow(station_2).to receive(:zone).and_return(5)
        allow(station_2).to receive(:pass)
      end

      it 'is not in a journey anymore when touch out' do
        subject.top_up(10)
        subject.touch_in(station_1)
        subject.touch_out(station_2)
        expect(subject.in_journey?).to eq(false)
      end
      it 'is in a journey when touch in and card has enough money for a journey' do
        subject.top_up(10)
        subject.touch_in(station)
        expect(subject.in_journey?).to eq(true)
      end
      it 'and raises an error when touch in and card has not enough money for a journey' do
        expect { subject.touch_in(station) }.to raise_error(ERROR_MESSAGES[:minimum_fair])
      end
      it 'and saves a station when touch in' do
        subject.top_up(10)
        subject.touch_in(station)
        journey = subject.journey_history.last
        expect(journey.entry_station).to eq(station)
      end
      it 'and changes the balane on the card when touch out' do
        subject.top_up(10)
        subject.touch_in(station)
        expect { subject.balance }.to change { subject.send(:deduct, MINIMUM_FAIR) }.by(-1)
      end
      it 'and changes the balane on the card when touch out' do
        subject.top_up(10)
        subject.touch_in(station_1)
        subject.touch_out(station_2)
        expect(subject.balance).to eq(5)
      end
      it 'and charges penalty when pouch-in and previous journey not complete' do
        subject.top_up(10)
        subject.touch_in(station_1)
        subject.touch_in(station_2)
        expect(subject.balance).to eq(3)
      end
      it 'and charges penalty when touch_out without touch_in' do
        subject.top_up(10)
        subject.touch_out(station_2)
        expect(subject.balance).to eq(3)
      end
      it 'and saves a station when touch out' do
        subject.top_up(10)
        subject.touch_in(station_1)
        subject.touch_out(station_2)
        journey = subject.journey_history.last
        expect(journey.exit_station).to eq(station_2)
      end
    end
  end
end
