# ref. http://qiita.com/items/26a03d3839ae85fb5779
worker_processes 3
timeout 30
preload_app false

# RACK_ENV = ENV["RACK_ENV"] || "development"

before_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Padrino.logger.info('Disconnected from ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    Resque.redis.quit
    Padrino.logger.info('Disconnected from Redis')
  end

  sleep 1
end

after_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection(::Padrino.env.to_sym)
    Padrino.logger.info('Connected to ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    Resque.redis = ENV['REDIS_URI']
    Padrino.logger.info('Connected to Redis')
  end
end
