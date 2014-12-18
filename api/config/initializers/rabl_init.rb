require 'rabl'

Rabl.configure do |config|
  config.view_paths = [Rails.root.join('app', 'views', 'api')]
end