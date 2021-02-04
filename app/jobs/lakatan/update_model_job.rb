module Lakatan
  class UpdateModelJob < ApplicationJob
    queue_as Lakatan.job_queue

    VALID_MODEL_NAMES = %w{Team Task User}
    VALID_ACTIONS = %w{create update destroy}

    def perform(model_name, model_id, notification_action)
      @update_request = Lakatan::UpdateModelRequest.new(
        model_name: model_name,
        model_id: model_id,
        notification_action: notification_action
      )

      process_model_change
      true
    end

    private

    attr_reader :update_request

    def process_model_change
      if update_request.notification_action == :destroy
        destroy_resource!
      else
        update_resource!
      end
    end

    def update_resource!
      model_instance = model_class.find_or_initialize_by(id: update_request.model_id)
      model_instance.update_attributes_from_api!
    end

    def destroy_resource!
      model_class.find_by!(id: update_request.model_id).destroy!
    end

    def model_class
      @model_class ||= "Lakatan::#{update_request.model_name}".constantize
    end
  end
end
