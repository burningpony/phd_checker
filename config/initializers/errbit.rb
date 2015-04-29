Airbrake.configure do |config|
  config.api_key = '9e24094e4b6f834c13faabbe9892adf3'
  config.project_id = '9e24094e4b6f834c13faabbe9892adf3'
  config.host    = 'burningpony-bugs.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
  config.ignore << 'SignalException' # This is thrown when cloud 66 deploys
end

class Airbrake::Sender
  def json_api_enabled?
    true
  end
end
