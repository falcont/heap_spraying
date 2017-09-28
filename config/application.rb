require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HeapSpraying
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_cable.disable_request_forgery_protection = false

    config.generators do |g|
      g.test_framwork :rspec,
                      fixtures: true,
                      view_spec: false,
                      helper_specs: false,
                      routing_specs: false,
                      request_specs: false,
                      controller_specs: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'

    end
  end
end
