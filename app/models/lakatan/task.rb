module Lakatan
  class Task < ApplicationRecord
    include Lakatan::ApiResource

    def random_user
      raffle = api_resource_class.new(id: id).raffle
      user_id = raffle.user_ids.first

      if !user_id
        raise Lakatan::Error.new(
          "Can't find random user_id for Lakatan::Task ##{id}"
        )
      end

      Lakatan::User.find_from_cache_or_create_from_api!(user_id)
    end
  end
end
