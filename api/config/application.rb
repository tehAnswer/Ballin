require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require 'neo4j/railtie'
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BallinAPI
    ITEMS_PER_PAGE = 15

    ASSIST_BONUS = 1.75
    DEFR_BONUS = 1.25
    OFR_BONUS = 1.5
    STEAL_BONUS = 3
    BLOCK_BONUS = 2

    FT_PENALTY = 3.5
    FG_PENALTY = 2
    LS_PENALTY = 1.25
    TURNOVER_PENALTY = 3

    POINTS_REVULSIVE = 19
    MINUTES_REVULSIVE = 21
    REVULSIVE = 15

    SPLASH_ATTEMPTS = 7
    SPLASH_RATIO = 80 
    SPLASH = 20

    RIM_PROTECTOR_BLOCKS = 3
    RIM_PROTECTOR_DEFR = 9
    RIM_PROTECTOR = 10

    NO_MISS_FGA = 7
    NO_MISS = 20

    UNSELFISH_ASSISTS = 7
    UNSELFISH_FGA = 10
    UNSELFISH = 10

    HUSTLER_STEALS = 4
    HUSTLER_BLOCKS = 4
    HUSTLER = 15

    FIVE_BY_FIVE = 555

    POSSESIONS_FREEAWAY_TURNOVERS = 5
    POSSESIONS_FREEAWAY = 20

    HACKED_FTM_RATIO = 40
    HACKED_FTA = 10
    HACKED = 20

    NIGHTMARE_FGM_RATIO = 30 
    NIGHTMARE_FGA = 9
    NIGHTMARE = 30

  class Application < Rails::Application
    
    config.generators do |g|
      g.orm             :neo4j
    end

    config.neo4j.id_property = :id
    config.neo4j.transform_rel_type = :legacy

    # Configure where the embedded neo4j database should exist
    # Notice embedded db is only available for JRuby
    # config.neo4j.session_type = :embedded_db  # default #server_db
    # config.neo4j.session_path = File.expand_path('neo4j-db', Rails.root)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
