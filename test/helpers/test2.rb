
require 'bunny'
require 'httparty'
require 'uri'

RSpec.describe 'test2' do

  context 'sample' do
    # it { expect(true).to eq true }
    # it { expect(true).to eq false }
    it 'abc' do
      connection = Bunny.new(automatically_recover: false)
      connection.start

      channel = connection.create_channel
      queue = channel.queue('dashboard.posts', durable: true)

      begin
        puts ' [*] Waiting for messages. To exit press CTRL+C'
        # block: true is only used to keep the main thread
        # alive. Please avoid using it in real world applications.
        queue.subscribe(block: true) do |_delivery_info, _properties, body|
          @data = body
          puts " [x] Received #{body}"
          base_url = "http://localhost:4000/rabbit/#{URI::encode(@data)}"
          HTTParty.get(base_url)
        end
      rescue Interrupt => _
        connection.close

        exit(0)
      ensure
        @data
      end
    end
  end
end
