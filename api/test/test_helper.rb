ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def parse(body)
    JSON.parse(body, symbolize_names: true)
  end
end
