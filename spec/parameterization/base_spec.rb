require './app/domains/parameterization/base'

describe Fyber::Parameterization::Base do
  let(:uid) { 'efreesen' }
  let(:pub0) { 'my_campaign' }
  let(:page) { 6 }

  let(:instance) { described_class.new(uid, pub0, page) }

  describe '.generate' do
    subject { described_class.generate(uid, pub0, page) }

    before do
      allow(described_class).to receive(:new).with(uid, pub0, page).and_return(instance)
    end

    it 'initializes an instance' do
      expect(described_class).to receive(:new).with(uid, pub0, page).and_call_original

      subject
    end

    it 'calls generate method on instance' do
      expect(instance).to receive(:generate)
      subject
    end
  end

  describe '#generate' do
    subject { instance.generate }

    context 'when all parameters are present' do
      let(:timestamp) { '1312553361' }
      let(:string) { 'appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b83&format=json&ip=109.235.143.113&locale=de&offer_types=112&page=6&ps_time=1312211903&pub0=my_campaign&timestamp=1312553361&uid=efreesen' }
      let(:string_for_hash) { "#{string}&b07a12df7d52e6c118e5d47d3f9e60135b109a1f" }
      let(:result_string) { "#{string}&hashkey=d0e55abd56fe46dda4e141684654e242fe118139" }

      before do
        allow(instance).to receive(:timestamp).and_return(timestamp)
      end

      it 'returns a valid result string' do
        expect(subject).to eq(result_string)
      end

      it 'sends string for hash calculation' do
        expect(Fyber::Cryptography::HashKey).to receive(:calculate).with(string_for_hash)
        subject
      end
    end

    context 'when uid is nil' do
      let(:uid) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when uid is empty' do
      let(:uid) { '' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when pub0 is nil' do
      let(:pub0) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when pub0 is empty' do
      let(:pub0) { '' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when page is nil' do
      let(:pub0) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end