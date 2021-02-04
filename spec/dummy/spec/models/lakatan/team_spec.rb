require 'rails_helper'

module Lakatan
  RSpec.describe Team, type: :model do
    it 'has a valid factory' do
      expect(build(:team)).to be_valid
    end

    it_behaves_like "api resource", 99 do
      let(:resource_changes) do
        {
          name: "Keepers of the seven keys",
          user_ids: [140, 154, 148, 139]
        }
      end
    end
  end
end
