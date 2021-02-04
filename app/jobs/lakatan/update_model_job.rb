module Lakatan
  class UpdateModelJob < ApplicationJob
    queue_as Lakatan.job_queue

    VALID_MODEL_NAMES = %w{Team Task User}
    VALID_ACTIONS = %w{create update destroy}

    def perform(name, id, action)
      self.model_name = name
      self.model_id = id
      self.action = action
      process_model_change
      true
    end

    private

    attr_reader :model_name, :model_id, :action

    def process_model_change
      if action == :destroy
        destroy_resource!
      else
        update_resource!
      end
    end

    def update_resource!
      model_instance = model_class.find_or_initialize_by(id: model_id)
      model_instance.update_attributes_from_api!
    end

    def destroy_resource!
      model_class.find_by!(id: model_id).destroy!
    end

    def model_class
      @model_class ||= "Lakatan::#{model_name}".constantize
    end

    def model_name=(value)
      if !VALID_MODEL_NAMES.include?(value)
        raise Lakatan::Error.new("invalid model name")
      end

      @model_name = value
    end

    def model_id=(value)
      if value.to_i.zero?
        raise Lakatan::Error.new("invalid model id")
      end

      @model_id = value.to_i
    end

    def action=(value)
      if !VALID_ACTIONS.include?(value)
        raise Lakatan::Error.new("invalid action. Must be 'create', 'update' or 'destroy'")
      end

      @action = value.to_sym
    end
  end
end
