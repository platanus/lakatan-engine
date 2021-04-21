require "rails"
require "require_all"
require "activeresource"
require "lakatan/engine"

module Lakatan
  extend self

  class Error < StandardError; end

  VALID_MODEL_NAMES = %w{Team Task User}
  VALID_MODEL_ACTIONS = %i{create update destroy}

  attr_writer :site_url, :url_prefix, :job_queue
  attr_accessor :authorization_token

  def models
    VALID_MODEL_NAMES.map do |model_name|
      {
        api: "Lakatan::Api::#{model_name}".constantize,
        active_record: "Lakatan::#{model_name}".constantize
      }
    end
  end

  def site_url
    return "https://lakatan.dev" unless @site_url

    @site_url
  end

  def url_prefix
    return "/api/v1/bearers/" unless @url_prefix

    @url_prefix
  end

  def job_queue
    return :default unless @job_queue

    @job_queue
  end

  def setup
    yield self
    require "lakatan"
  end
end
