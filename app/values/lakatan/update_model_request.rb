module Lakatan
  class UpdateModelRequest
    VALID_MODEL_NAMES = %w{Team Task User}
    VALID_ACTIONS = %i{create update destroy}

    def initialize(params = {})
      params = params.with_indifferent_access
      self.model_name = params[:model_name]
      self.model_id = params[:model_id]
      self.notification_action = params[:notification_action]
    end

    attr_reader :model_name, :model_id, :notification_action

    private

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

    def notification_action=(value)
      if !VALID_ACTIONS.include?(value.to_s.to_sym)
        raise Lakatan::Error.new(
          "invalid notification_action. Must be 'create', 'update' or 'destroy'"
        )
      end

      @notification_action = value.to_sym
    end
  end
end
