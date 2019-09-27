WaterDrop.setup do |config|
  config.deliver = true
  config.kafka.seed_brokers = %w[kafka://127.0.0.1:9092]
end
