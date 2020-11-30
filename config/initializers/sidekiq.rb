Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://:fasttrade2020!@srv-captain--redis:6379/0' }
  end