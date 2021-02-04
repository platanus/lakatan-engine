require 'rails_helper'

module Lakatan
  RSpec.describe UpdateModelJob, type: :job do
    include ActiveJob::TestHelper

    let(:model_name) { "Task" }
    let(:model_id) { 48 }
    let(:notification_action) { "create" }

    def perform_now
      described_class.perform_now(model_name, model_id, notification_action)
    end

    def perform_later
      described_class.perform_later(model_name, model_id, notification_action)
    end

    before { VCR.insert_cassette("resources/task") }

    after { VCR.eject_cassette }

    it 'queues the job' do
      expect { perform_later }.to(
        change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
      )
    end

    context "with no notification_action" do
      let(:notification_action) { nil }

      it { expect { perform_now }.to raise_error(/Must be 'create', 'update' or 'destroy'/) }
    end

    context "with invalid model name" do
      let(:model_name) { "Invalid" }

      it { expect { perform_now }.to raise_error(/invalid model name/) }
    end

    context "with invalid model id" do
      let(:model_id) { "Invalid" }

      it { expect { perform_now }.to raise_error(/invalid model id/) }
    end

    context "with blank model id" do
      let(:model_id) { "" }

      it { expect { perform_now }.to raise_error(/invalid model id/) }
    end

    context "with nil model id" do
      let(:model_id) { nil }

      it { expect { perform_now }.to raise_error(/invalid model id/) }
    end

    context "with create notification_action" do
      let(:notification_action) { "create" }

      it { expect { perform_now }.to change { Lakatan::Task.count }.from(0).to(1) }

      context "with existent model" do
        before do
          create(:task, id: model_id)
        end

        it { expect(perform_now).to eq(true) }
      end
    end

    context "with update notification_action" do
      let(:notification_action) { "update" }

      it { expect { perform_now }.to change { Lakatan::Task.count }.from(0).to(1) }

      context "with existent model" do
        before do
          create(:task, id: model_id)
        end

        it { expect(perform_now).to eq(true) }
      end
    end

    context "with destroy notification_action" do
      let(:notification_action) { "destroy" }

      it { expect { perform_now }.to raise_error(ActiveRecord::RecordNotFound) }

      context "with existent model" do
        before do
          create(:task, id: model_id)
        end

        it { expect { perform_now }.to change { Lakatan::Task.count }.from(1).to(0) }
        it { expect(perform_now).to eq(true) }
      end
    end
  end
end

