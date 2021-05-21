module Lakatan
  module ApiResource
    extend ActiveSupport::Concern

    class_methods do
      def find_from_cache_or_create_from_api!(id)
        resource = find_or_initialize_by(id: id)
        resource.update_attributes_from_api! if resource.new_record?
        resource
      end
    end

    def update_attributes_from_api!
      raise Lakatan::Error.new("can't update resource without id") if id.blank?

      load_defined_attributes
      load_dynamic_attributes
      save!
    end

    def get_dynamic_attr(key)
      dynamic_attributes.with_indifferent_access[key]
    end

    private

    def load_defined_attributes
      api_resource.class.resource_attributes.each do |attribute_name|
        value = api_resource.send(attribute_name)
        send("#{attribute_name}=", value)
      end
    end

    def load_dynamic_attributes
      self.dynamic_attributes = api_resource.dynamic_attributes
    end

    def api_resource
      @api_resource ||= api_resource_class.find(id)
    end

    def api_resource_class
      @api_resource_class ||= self.class.name.split("::").insert(1, "Api").join("::").constantize
    end
  end
end
