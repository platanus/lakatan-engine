module Lakatan
  module Api
    class User < Lakatan::Api::BaseModel
      declare_attribute(:name, :string)
      declare_attribute(:email, :string)
      declare_attribute(:slack_id, :string)
      declare_attribute(:personal_interview_url, :string)
      declare_attribute(:technical_interview_url, :string)
      declare_attribute(:created_at, :datetime)
      declare_attribute(:updated_at, :datetime)
      declare_attribute(:last_org, :integer)
      declare_attribute(:team_ids)
      declare_nested_collection(:teams)
    end
  end
end
