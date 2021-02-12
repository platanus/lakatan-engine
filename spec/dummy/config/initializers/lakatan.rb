Lakatan.setup do |config|
  config.site_url = "https://lakatan.dev"
  config.url_prefix = "/api/v1/bearers/"
  config.authorization_token = ENV.fetch("LAKATAN_AUTHORIZATION_TOKEN", "xxx")
end
