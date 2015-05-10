require './app/domains/parameterization/base'

describe Fyber::Parameterization::Base do
  describe '.generate' do
    let(:uid) { 'efreesen' }
    let(:pub0) { 'my_campaign' }
    let(:page) { 6 }

    let(:instance) { described_class.new(uid, pub0, page) }

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
end