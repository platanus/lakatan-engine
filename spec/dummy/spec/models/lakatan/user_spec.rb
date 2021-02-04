require 'rails_helper'

module Lakatan
  RSpec.describe User, type: :model do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it_behaves_like "api resource", 115 do
      let(:resource_changes) do
        {
          name: "Andrés Matte",
          team_ids: [103, 97, 96]
        }
      end
    end
  end
end
