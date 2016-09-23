require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

RSpec.describe Kickfire::Company do
  it 'can be initialized' do
    expect(Kickfire::Company.new).to be_an_instance_of(Kickfire::Company)
  end

  describe 'query' do
    it 'finds with ip' do
      VCR.use_cassette('8.8.8.8',) do
        Kickfire::Company.find('8.8.8.8', "valid_key")
      end
    end
  end

  describe 'kickfire errors' do
    it 'receives error with no api key' do
      VCR.use_cassette('no api key') do
        expect{ Kickfire::Company.find('8.8.8.8', nil) }.to raise_error("901 No API Key provided.")
      end
    end
    it 'receives error with invalid api key' do
      VCR.use_cassette('invalid api key') do
        expect{ Kickfire::Company.find('8.8.8.8',"invalid key") }.to raise_error("900 Authorization failed!")
      end
    end
  end
end
