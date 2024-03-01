# config/initializers/sidekiq.rb
# REDIS_URL=redis://redis.example.com:6379/0
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end
