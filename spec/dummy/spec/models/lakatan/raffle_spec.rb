require "rails_helper"

describe Lakatan::Raffle do
  describe "#raffle" do
    let(:task_id) { 1 }
    let(:user_ids) { [1, 3] }

    before { VCR.insert_cassette("resources/raffle") }

    after { VCR.eject_cassette }

    def perform
      described_class.raffle(task_id: task_id, user_ids: user_ids)
    end

    it { expect(perform).to be_a(described_class) }
    it { expect(perform.user_ids).to eq([1]) }
    it { expect(perform.task_id).to eq(1) }
  end

  describe "#users" do
    let(:user_ids) { [139, 666, 999] }
    let(:raffle) { described_class.new }

    before do
      VCR.insert_cassette("resources/users")
      allow(raffle).to receive(:user_ids).and_return(user_ids)
    end

    after { VCR.eject_cassette }

    it { expect(raffle.users.count).to eq(1) }
  end

  describe "#task" do
    let(:task_id) { 48 }
    let(:raffle) { described_class.new }

    before do
      VCR.insert_cassette("resources/task")
      allow(raffle).to receive(:task_id).and_return(task_id)
    end

    after { VCR.eject_cassette }

    it { expect(raffle.task).to be_a(Lakatan::Task) }
  end
end
