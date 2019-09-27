
require 'kafka'
require 'httparty'
require 'uri'

RSpec.describe 'test' do

  context 'sample' do
    # it { expect(true).to eq true }
    # it { expect(true).to eq false }
    it 'abc' do
      kafka = Kafka.new(["127.0.0.1:9092"])
      kafka.each_message(topic: "test") do |message|
        puts message.offset, message.key, message.value

        base_url = "http://localhost:4000/kafka/#{URI::encode(message.value)}"

        HTTParty.get(base_url)
      end
    end
  end
end
