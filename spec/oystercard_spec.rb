require 'oystercard'
DEFAULT_CAPACITY = 90
MINIMUM_FAIR = 1
ERROR_MESSAGES = {
  :exceeded_limit => 'The amount you are trying to top up is above limit = 90 GBR',
  :minimum_fair => 'Minimum amount to start a journey is 1 GBR'
}

describe Oystercard do
  context 'Newly initialized Oyster card has a default balance' do
    it { expect(subject).to respond_to(:touch_in).with(1).argument  }
    it { expect(subject).to respond_to :touch_out}
    it { expect(subject).to respond_to :in_journey?}
    it { expect(subject).to respond_to(:top_up).with(1).argument }
    let(:station) { double :station }
    before {
      allow(station).to receive(:pass).and_return(true)
    }


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
      it 'return status false when touch out' do
        subject.top_up(10)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.in_journey?).to eq(false)
      end
      it 'and it returns true when touch in and card has enough money for a journey' do
        subject.top_up(10)
        subject.touch_in(station)
        expect(subject.in_journey?).to eq(true)
      end
      it 'and it raises an error when touch in and card has not enough money for a journey' do
        expect { subject.touch_in(station) }.to  raise_error(ERROR_MESSAGES[:minimum_fair])
      end
      it 'when touch out it changes the balane on the card' do
        subject.top_up(10)
        subject.touch_in(station)
        expect{ subject.balance }.to change { subject.send(:deduct, MINIMUM_FAIR) }.by(-1)
      end
    end
  end
end
