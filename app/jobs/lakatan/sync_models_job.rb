module Lakatan
  class SyncModelsJob < ApplicationJob
    queue_as Lakatan.job_queue

    def perform
      Lakatan.models.each do |model|
        update_model_data(
          model[:active_record],
          model[:api]
        )
      end
    end

    private

    def update_model_data(ar_model, api_model)
      api_ids = api_model.all.map do |api_resource|
        record = ar_model.find_or_initialize_by(id: api_resource.id)
        record.update_attributes_from_api!
        record.id
      end

      extra_persisted_ids = (ar_model.ids - api_ids)
      ar_model.where(id: extra_persisted_ids).destroy_all if extra_persisted_ids.any?
    end
  end
end
