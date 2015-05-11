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

    context 'using example from DOC' do
      let(:string) { 'appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1&e95a21621a1865bcbae3bee89c4d4f84' }

      subject { described_class.new(string).calculate }

      it 'returns the calculated hash' do
        expect(subject).to eq('7a2b1604c03d46eec1ecd4a686787b75dd693c4d')
      end
    end

    context 'when string is present' do
      it 'returns the calculated hash' do
        expect(subject).to eq('01c3c27304a2ccca73e85bd23fa2023844c81243')
      end
    end

    context 'when string is nil' do
      let(:string) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when string is empty' do
      let(:string) { '' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
