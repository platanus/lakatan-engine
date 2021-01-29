require "rails"
require "require_all"
require "activeresource"
require "lakatan/engine"

module Lakatan
  extend self

  attr_accessor :site_url, :url_prefix, :authorization_token

  def setup
    yield self
    require "lakatan"
  end
end
