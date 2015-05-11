require './app/domains/integration/offer_api_adapter'

describe Fyber::Integration::OfferAPIAdapter do
  let(:uid) { 'player1' }
  let(:pub0) { 'campaign2' }
  let(:page) { 2 }

  let(:instance) { described_class.new(uid, pub0, page) }

  describe '.request' do
    subject do
      VCR.use_cassette("request_success", match_requests_on: [:method, :host, :path]) do
        described_class.request(uid, pub0, page)
      end
    end

    before do
      allow(described_class).to receive(:new).with(uid, pub0, page).and_return(instance)
    end

    it 'initializes an instance' do
      expect(described_class).to receive(:new).with(uid, pub0, page).and_call_original

      subject
    end

    it 'calls request method on instance' do
      expect(instance).to receive(:request)
      subject
    end
  end

  describe '#request' do
    context 'when parameters are present' do
      context 'and request returns results' do
        let(:result_array) do
          [
            {
              title: "Test1",
              thumbnail: "http://users.wfu.edu/matthews/misc/graphics/ResVsComp/25percent4x4.png",
              payout: 2.34
            },
            {
              title: "Test2",
              thumbnail: "http://www.rickdoble.net/low_resolution/low_resolution_22.jpg",
              payout: 1.86
            },
            {
              title: "Test3",
              thumbnail: "http://booksat.scarlettrugers.com/bookcoverdesign/wp-content/uploads/2012/03/catpixelated.jpg",
              payout: 2.17
            }
          ]
        end

        subject do
          VCR.use_cassette("request_success", match_requests_on: [:method, :host, :path]) do
            instance.request
          end
        end
        
        it 'returns the results array' do
          expect(subject).to eq(result_array)
        end
      end

      context 'and request returns no result' do
        subject do
          VCR.use_cassette("request_no_content", match_requests_on: [:method, :host, :path]) do
            instance.request
          end
        end
        
        it 'returns an empty array' do
          expect(subject).to eq('No offers available')
        end
      end

      context 'and request returns error' do
        subject do
          VCR.use_cassette("request_error", match_requests_on: [:method, :host, :path]) do
            instance.request
          end
        end
        
        it 'returns an empty array' do
          expect(subject).to eq('An invalid hashkey for this appid was given as a parameter in the request.')
        end
      end
    end

    xcontext 'when string is nil' do
      let(:string) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    xcontext 'when string is empty' do
      let(:string) { '' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
