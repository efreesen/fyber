require './app/domains/cryptography/hash_key'

describe Fyber::Cryptography::HashKey do
  let(:string) { 'appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b83&ip=109.235.143.113&locale=de&offer_types=112&page=6&ps_time=1312211903&pub0=my_campaign&timestamp=1312553361&uid=efreesen&b07a12df7d52e6c118e5d47d3f9e60135b109a1f' }
  let(:instance) { described_class.new(string) }

  describe '.calculate' do
    subject { described_class.calculate(string) }

    before do
      allow(described_class).to receive(:new).with(string).and_return(instance)
    end

    it 'initializes an instance' do
      expect(described_class).to receive(:new).with(string).and_call_original

      subject
    end

    it 'calls calculate method on instance' do
      expect(instance).to receive(:calculate)
      subject
    end
  end

  describe '#calculate' do
    subject { instance.calculate }

    it 'returns the calculated hash' do
      expect(subject).to eq('01c3c27304a2ccca73e85bd23fa2023844c81243')
    end
  end
end
