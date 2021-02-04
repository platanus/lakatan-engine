module Lakatan
  class NotificationsController < ::ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      respond_to do |format|
        format.json { render update_model }
      end
    end

    private

    def update_model
      Lakatan::UpdateModelJob.perform_later(
        update_request.model_name,
        update_request.model_id,
        update_request.notification_action
      )
      { json: { result: :success }.to_json, status: :accepted }
    rescue StandardError => e
      { json: { result: :failure, error: e.message }.to_json, status: :internal_server_error }
    end

    def update_request
      @update_request ||= Lakatan::UpdateModelRequest.new(permitted_params)
    end

    def permitted_params
      params.permit(
        :model_name,
        :model_id,
        :notification_action
      ).to_hash
    end
  end
end
