require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe Kickfire::Company do
  it 'can be initialized' do
    expect(Kickfire::Company.new).to be_an_instance_of(Kickfire::Company)
  end

  describe 'query' do
    it 'finds with ip and api key' do
      VCR.use_cassette('8.8.8.8',) do
        expect(Kickfire::Company.find('8.8.8.8', api_key: "valid_key").name).to eq 'Google, Inc.'
      end
    end

    describe 'with configured api key' do
      before do
        stub_const("Kickfire::API_KEY", "valid_key")
      end

      it 'finds ip' do
        VCR.use_cassette('8.8.8.8',) do
          expect(Kickfire::Company.find('8.8.8.8').name).to eq 'Google, Inc.'
        end
      end

      it 'finds isp' do
        VCR.use_cassette('1.1.1.1') do
          expect(Kickfire::Company.find('1.1.1.1').isp?).to eq true
        end
      end

      it 'finds Terminus' do
        VCR.use_cassette('38.140.7.60') do
          expect(Kickfire::Company.find('38.140.7.60').name).to eq "Terminus Software, LLC"
        end
      end

      it 'returns a twitter url' do
        VCR.use_cassette('8.8.8.8',) do
          expect(Kickfire::Company.find('8.8.8.8').twitter_url).to eq 'http://twitter.com/google'
        end
      end

      it 'returns an address' do
        VCR.use_cassette('8.8.8.8',) do
          expect(Kickfire::Company.find('8.8.8.8').address).to eq '1600 Amphitheatre Parkway, Mountain View, 94043'
        end
      end
    end
  end

  describe 'kickfire errors' do
    it 'receives error with no api key' do
      VCR.use_cassette('no api key') do
        expect{ Kickfire::Company.find('8.8.8.8', api_key: nil) }.to raise_error(Kickfire::AuthenticationError, "901 No API Key provided.")
      end
    end
    it 'receives error with invalid api key' do
      VCR.use_cassette('invalid api key') do
        expect{ Kickfire::Company.find('8.8.8.8', api_key: "invalid key") }.to raise_error(Kickfire::AuthenticationError, "900 Authorization failed!")
      end
    end
  end
end
