module Lakatan
  class Team < ApplicationRecord
    include Lakatan::ApiResource

    serialize :user_ids, Array
    serialize :task_ids, Array
  end
end
