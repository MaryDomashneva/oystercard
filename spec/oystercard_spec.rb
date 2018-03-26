require 'oystercard'
DEFAULT_CAPACITY = 0

describe Oystercard do
  context 'Newly initialized Oyster card has a balance by default' do
    context 'when balance set-up to "0"' do
      it "uses that balance" do
        balance = DEFAULT_CAPACITY
        card = Oystercard.new(0)
        expect(card.balance).to eq(balance)
      end
    end
  end
end
