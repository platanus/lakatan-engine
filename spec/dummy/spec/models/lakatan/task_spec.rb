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

    describe "#random_user" do
      let(:user_id) { double }
      let(:user_ids) { [user_id] }

      let(:raffle) do
        instance_double(
          "Lakatan::Api::Raffle",
          user_ids: user_ids
        )
      end

      let(:task_api) do
        instance_double(
          "Lakatan::Api::Task",
          raffle: raffle
        )
      end

      let(:task) { create(:task) }
      let(:user) { double }

      before do
        allow(Lakatan::Api::Task).to receive(:new).and_return(task_api)
        allow(Lakatan::User).to receive(:find_from_cache_or_create_from_api!)
          .and_return(user)
      end

      def perform
        task.random_user
      end

      it "returns expected user" do
        expect(perform).to eq(user)
        expect(Lakatan::Api::Task).to have_received(:new).with(id: task.id)
        expect(Lakatan::User).to have_received(:find_from_cache_or_create_from_api!)
          .with(user_id)
      end

      context "with not found users" do
        let(:user_ids) { [] }

        it "returns expected user" do
          expect { perform }.to raise_error(Lakatan::Error)
          expect(Lakatan::Api::Task).to have_received(:new).with(id: task.id)
          expect(Lakatan::User).not_to have_received(:find_from_cache_or_create_from_api!)
        end
      end
    end
  end
end
