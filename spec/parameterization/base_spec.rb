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
    let(:timestamp) { '1312553361' }
    let(:string) { 'appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b83&ip=109.235.143.113&locale=de&offer_types=112&page=6&ps_time=1312211903&pub0=my_campaign&timestamp=1312553361&uid=efreesen' }
    let(:result_string) { "#{string}&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d" }

    subject { instance.generate }

    before do
      allow(instance).to receive(:timestamp).and_return(timestamp)
    end

    it 'returns a valid result string' do
      expect(subject).to eq(result_string)
    end

    it 'sends string for hash calculation' do
      expect(Fyber::Cryptography::HashKey).to receive(:calculate).with(string)
      subject
    end
  end
end