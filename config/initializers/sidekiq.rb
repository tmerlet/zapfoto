redis_url = ENV["REDISTOGO_URL"] || "127.0.0.1:6379"

config_params = {
  :url => redis_url,
  :namespace => 'zapfoto'
}

Sidekiq.configure_server { |config| config.redis = config_params }

Sidekiq.configure_client { |config| config.redis = config_params }
