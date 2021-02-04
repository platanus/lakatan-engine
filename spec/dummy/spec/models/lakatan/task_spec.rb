require 'rails_helper'

module Lakatan
  RSpec.describe Task, type: :model do
    it 'has a valid factory' do
      expect(build(:task)).to be_valid
    end

    it_behaves_like "api resource", 48 do
      let(:resource_changes) do
        {
          name: "Primera entrevista startup",
          team_id: 100
        }
      end
    end
  end
end
