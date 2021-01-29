require "rails_helper"

describe Lakatan::Task do
  it_behaves_like "find resource", 48 do
    it { expect(resource.id).to eq(resource_id) }
    it { expect(resource.name).to eq("Primera entrevista startup") }
    it { expect(resource.goal).to eq("Ir a la primera entrevista startup PV") }
    it { expect(resource.raffle_type).to eq("Equity") }
    it { expect(resource.label_id).to eq(0) }
    it { expect(resource.team_id).to eq(100) }
    it { expect(resource.user_minimum).to eq(1) }
    it { expect(resource.created_at).to be_a(DateTime) }
    it { expect(resource.updated_at).to be_a(DateTime) }
  end

  it_behaves_like "all resources"

  describe "#team" do
    let(:team_id) { nil }
    let(:task) { described_class.new }

    before do
      VCR.insert_cassette("resources/team")
      allow(task).to receive(:team_id).and_return(team_id)
    end

    after { VCR.eject_cassette }

    it { expect(task.team).to be_nil }

    context "with some teams matching team_ids" do
      let(:team_id) { 99 }

      it { expect(task.team).to be_a(Lakatan::Team) }
    end
  end

  describe "#raffle" do
    let(:task_id) { 1 }
    let(:task) { described_class.new(id: task_id) }
    let(:user_ids) { double }

    before do
      allow(Lakatan::Raffle).to receive(:raffle)
    end

    it do
      expect(Lakatan::Raffle).to receive(:raffle)
        .with(user_ids: user_ids, task_id: task_id).once
      task.raffle(user_ids: user_ids)
    end
  end
end
