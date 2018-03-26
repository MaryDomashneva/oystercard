require 'oystercard'
DEFAULT_CAPACITY = 90
ERROR_MESSAGES = {
  :exceeded_limit => 'The amount you are trying to top up is above limit = 90'
}

describe Oystercard do
  context 'Newly initialized Oyster card has a balance by default' do
    context 'initial balance set-up to "0"' do
      it 'uses that balance' do
        balance = 0
        card = Oystercard.new(0)
        expect(card.balance).to eq(balance)
      end

      context 'Oyser card can be top_up' do
        it { expect(subject).to respond_to(:top_up).with(1).argument }

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
        it { expect(subject).to respond_to(:deduct).with(1).argument }
      end
      it 'returns new balance when deduct' do
        amount_top_up = 80
        subject.top_up(amount_top_up)
        amount_deduct = 10
        expect(subject.deduct(amount_deduct)).to eq(70)
      end
    end
  end
end
