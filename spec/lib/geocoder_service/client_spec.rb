RSpec.describe GeocoderService::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }

  before do
    stubs.post('/') { [status, headers, body.to_json] }
  end

  describe '#coordinates for valid city' do
    let(:status) { 200 }
    let(:body) { [45.05,90.05].to_json  }

    it 'returns coordinates' do
      expect(subject.coordinates('valid.city')).to eq(JSON.parse(body))
    end
  end

  describe '#coordinates for invalid city' do
    let(:status) { 204 }

    it 'returns empty coordinates' do
      expect(subject.coordinates('invalid.city')).to be_nil
    end
  end

  describe '#coordinates (nil token)' do
    let(:status) { 422 }

    it 'returns a nil value' do
      expect(subject.coordinates('nil')).to be_nil
    end
  end
end
