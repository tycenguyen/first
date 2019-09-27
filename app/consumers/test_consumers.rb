class TestConsumer < ApplicationConsumer
  def consume
    Karafka.logger.info "New [test] event: #{params}"
  end
end
