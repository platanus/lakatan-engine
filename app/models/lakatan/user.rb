module Lakatan
  class User < ApplicationRecord
    include Lakatan::ApiResource

    serialize :team_ids, Array
  end
end
