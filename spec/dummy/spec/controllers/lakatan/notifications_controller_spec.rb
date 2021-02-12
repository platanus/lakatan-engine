require 'rails_helper'

module Lakatan
  RSpec.describe NotificationsController do
    routes { Lakatan::Engine.routes }

    describe 'POST notifications' do
      let(:model_name) { "Task" }
      let(:model_id) { 48 }
      let(:notification_action) { "create" }
      let(:params) do
        {
          model_name: model_name,
          model_id: model_id,
          notification_action: notification_action
        }
      end

      before do
        allow(Lakatan::UpdateModelJob).to receive(:perform_later)
        post(:create, params: params, format: :json)
      end

      it { expect(response).to have_http_status(:accepted) }

      context "with invalid model name" do
        let(:model_name) { "XXX" }

        it { expect(response).to have_http_status(:internal_server_error) }
      end

      context "with invalid model id" do
        let(:model_id) { "" }

        it { expect(response).to have_http_status(:internal_server_error) }
      end

      context "with invalid notification_action" do
        let(:model_id) { "invalid" }

        it { expect(response).to have_http_status(:internal_server_error) }
      end
    end
  end
end
