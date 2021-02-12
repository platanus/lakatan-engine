module Lakatan
  class User < ApplicationRecord
    include Lakatan::ApiResource

    serialize :team_ids, Array

    def first_name
      get_name_part(:first)
    end

    def last_name
      get_name_part(:last)
    end

    private

    def get_name_part(part)
      name.to_s.split(" ").send(part)
    end
  end
end
