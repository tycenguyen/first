require "kafka"
# require 'httparty'

class KafkaConsumer
  include HTTParty

  def process
    # $redis = Redis::Namespace.new("dashboard:#{Rails.env}", redis: Redis.new)

    kafka = Kafka.new(["127.0.0.1:9092"])
    kafka.each_message(topic: "test") do |message|
      puts message.offset, message.key, message.value

      base_url = "localhost:4000/kafka/#{message.value}"

      HTTParty.get(base_url)
    end
  end
end
