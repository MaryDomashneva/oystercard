require 'oystercard'

describe Station do
  it { expect(subject).to respond_to(:pass) }
  context 'when trying to pass a barrier on station' do
    let(:card) { double :oystercard }
    before do
      allow(card).to receive(:touch_in).and_return(true)
    end
    it 'actually passing the station' do
      expect(subject.pass).to eq(true)
    end
  end
end
