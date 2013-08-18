Airbrake.configure do |config|
  config.api_key = 'c73384c7a925c37e6fccedc42fcae895'
  config.host    = 'kbn-errbit.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end
