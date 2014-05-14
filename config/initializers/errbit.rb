Airbrake.configure do |config|
  config.api_key = '9e24094e4b6f834c13faabbe9892adf3'
  config.host    = 'bugs.burningpony.com'
  config.port    = 80
  config.secure  = config.port == 443
end
