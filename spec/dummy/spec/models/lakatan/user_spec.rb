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

    describe "#first|last_name" do
      let(:name) { "Leandro Segovia" }
      let(:user) { build_stubbed(:user, name: name) }

      it { expect(user.first_name).to eq("Leandro") }
      it { expect(user.last_name).to eq("Segovia") }

      context "with more than two words" do
        let(:name) { "Leandro Danilo Luis Segovia Longone" }

        it { expect(user.first_name).to eq("Leandro") }
        it { expect(user.last_name).to eq("Longone") }
      end

      context "with no name" do
        let(:name) { nil }

        it { expect(user.first_name).to eq(nil) }
        it { expect(user.last_name).to eq(nil) }
      end
    end
  end
end
