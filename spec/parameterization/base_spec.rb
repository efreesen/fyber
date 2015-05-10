require './app/domains/parameterization/base'

describe Fyber::Parameterization::Base do
  describe '.generate' do
    let(:hash) { {} }
    let(:instance) { described_class.new(hash) }

    subject { described_class.generate(hash) }

    before do
      allow(described_class).to receive(:new).with(hash).and_return(instance)
    end

    it 'initializes an instance' do
      expect(described_class).to receive(:new).with(hash).and_call_original

      subject
    end

    it 'calls generate method on instance' do
      expect(instance).to receive(:generate)
      subject
    end
  end
end