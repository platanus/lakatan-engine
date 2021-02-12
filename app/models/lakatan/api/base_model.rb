module Lakatan
  module Api
    class BaseModel < ActiveResource::Base
      include Lakatan::ResourceAttributes

      self.site = Lakatan.site_url
      self.prefix = Lakatan.url_prefix
      headers["Authorization"] = "Bearer #{Lakatan.authorization_token}"
    end
  end
end
