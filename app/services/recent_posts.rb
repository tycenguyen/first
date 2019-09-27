class RecentPosts
  KEY = "recent_posts"
  STORE_LIMIT = 5

  def self.list(limit = STORE_LIMIT)
    $redis.lrange(KEY, 0, limit-1).map do |raw_post|
      raw_post
      # JSON.parse(raw_post).with_indifferent_access
      # JSON.parse(content.gsub('\"', '"'))
    end
  end


  def self.push(raw_post)
    $redis.lpush(KEY, raw_post)
    $redis.ltrim(KEY, 0, STORE_LIMIT-1)
  end

  def self.get_data_redis
    $redis.lrange('redis_data', 0, 10).map do |raw_post|
      raw_post
      # JSON.parse(raw_post).with_indifferent_access
      # JSON.parse(content.gsub('\"', '"'))
    end
  end

  def self.get_kafka_redis
    $redis.lrange('kafka', 0, 10).map do |raw_post|
      raw_post
    end
  end

  def self.push_kafka_redis(raw_post)
    $redis.lpush('kafka', raw_post)
  end

  def self.get_rabbit_redis
    $redis.lrange('rabbit', 0, 10).map do |raw_post|
      raw_post
    end
  end

  def self.push_rabbit_redis(raw_post)
    $redis.lpush('rabbit', raw_post)
  end
end
