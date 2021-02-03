require "rails_helper"

describe Lakatan::Team do
  it_behaves_like "find resource", 99 do
    let(:expected_attributes) do
      %i{
        created_at
        name
        purpose
        task_ids
        updated_at
        user_ids
      }
    end

    it { expect(resource.id).to eq(resource_id) }
    it { expect(resource.name).to eq("Keepers of the seven keys") }
    it { expect(resource.purpose).to match(/Definir cómo se entregan accesos/) }
    it { expect(resource.created_at).to be_a(DateTime) }
    it { expect(resource.updated_at).to be_a(DateTime) }
    it { expect(resource.user_ids).to contain_exactly(139, 140, 148, 154) }
    it { expect(resource.task_ids).to eq([]) }
  end

  it_behaves_like "all resources"

  describe "#tasks" do
    let(:task_ids) { [] }
    let(:team) { described_class.new }

    before do
      VCR.insert_cassette("resources/tasks")
      allow(team).to receive(:task_ids).and_return(task_ids)
    end

    after { VCR.eject_cassette }

    it { expect(team.tasks).to eq([]) }
  end

  describe "#users" do
    let(:user_ids) { [] }
    let(:team) { described_class.new }

    before do
      VCR.insert_cassette("resources/users")
      allow(team).to receive(:user_ids).and_return(user_ids)
    end

    after { VCR.eject_cassette }

    it { expect(team.users).to eq([]) }

    context "with some users matching user_ids" do
      let(:user_ids) { [139, 666, 999] }

      it { expect(team.users.count).to eq(1) }
    end
  end
end
