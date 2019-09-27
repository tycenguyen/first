require "kafka"

class HomeController < ApplicationController
  def index
    @rabbit_list = RecentPosts.get_rabbit_redis || []

    @redis_list = RecentPosts.get_data_redis

    @kafka_list = RecentPosts.get_kafka_redis
  end

  def create
    Publisher.publish("dashboard.posts",  {data: Time.current})

    # WaterDrop::AsyncProducer.call('Hi water drop', topic: 'test')
    m = params[:mess] || 'new mess'
    WaterDrop::SyncProducer.call(m, topic: 'test')

    head :no_content
  end

  def kafka_receive
    RecentPosts.push_kafka_redis(params[:mess])
  end

  def rabbit_receive
    RecentPosts.push_rabbit_redis(params[:mess])
  end
end
