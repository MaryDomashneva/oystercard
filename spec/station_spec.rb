require 'oystercard'

describe Station do
  it { expect(subject).to respond_to(:pass) }
  it { expect(subject).to respond_to(:reject) }
  context 'when trying to pass a barrier on station' do
    let(:card) { double :oystercard }
    before {
      allow(card).to receive(:touch_in).and_return(true)
    }
    it 'actually passing the station' do
      expect(subject.pass).to eq(true)
    end
    it 'returns fals if reject' do
      expect(subject.reject).to eq(false)
    end
  end
end
