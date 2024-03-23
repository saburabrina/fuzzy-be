require 'sidekiq'
require 'sidekiq-status'

Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379/0' }
    Sidekiq::Status.configure_server_middleware config
    Sidekiq::Status.configure_client_middleware config
end

Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://localhost:6379/0' }
    Sidekiq::Status.configure_client_middleware config
end