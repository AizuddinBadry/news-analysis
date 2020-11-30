Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://redistogo:85e0fafd6a55897f7c2ea1d110c76337@scat.redistogo.com:10075/' }
  end