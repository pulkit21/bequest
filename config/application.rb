require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bequest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
    config.eager_load_paths << "#{Rails.root}/lib"
    config.autoload_paths += %W(#{config.root}/app/services)
    config.autoload_paths += %W(#{config.root}/app/models/products)
    config.filter_parameters << :password

    if Rails.env.production?
      Raven.configure do |config|
        config.dsn = 'https://d56db32e40de46d281a4e596834757ff:73e602eb48554b8ebd76a6ab6af02517@sentry.io/204831'
      end
    end
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
