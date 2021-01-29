module Lakatan
  class Raffle < Lakatan::BaseModel
    self.prefix = "#{Lakatan.url_prefix}tasks/:task_id/"

    declare_attribute(:task_id)
    declare_attribute(:user_ids)
    declare_nested_resource(:task)
    declare_nested_collection(:users)

    def self.raffle(task_id: nil, user_ids: nil)
      params = {}
      params[:raffle] = { user_ids: user_ids } if user_ids
      raffle = new(params)
      raffle.prefix_options[:task_id] = task_id
      raffle.save
      raffle
    end
  end
end
