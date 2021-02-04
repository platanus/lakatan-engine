module Lakatan
  module ApiResource
    extend ActiveSupport::Concern

    def update_attributes_from_api!
      raise Lakatan::Error.new("can't update resource without id") if id.blank?

      api_resource.class.resource_attributes.each do |attribute_name|
        value = api_resource.send(attribute_name)
        send("#{attribute_name}=", value)
      end

      save!
    end

    private

    def api_resource
      @api_resource ||= api_resource_class.find(id)
    end

    def api_resource_class
      @api_resource_class ||= self.class.name.split("::").insert(1, "Api").join("::").constantize
    end
  end
end
