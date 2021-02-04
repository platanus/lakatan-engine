# frozen_string_literal: true

shared_examples 'find resource' do |res_id|
  let(:resource_name) { described_class.name.split("::").last.downcase }
  let(:resource_id) { res_id }
  let(:resource) { described_class.find(resource_id) }

  before { VCR.insert_cassette("resources/#{resource_name}") }

  after { VCR.eject_cassette }

  it { expect(resource).to be_a(described_class) }
  it { expect(described_class.resource_attributes).to contain_exactly(*expected_attributes) }
end

shared_examples 'all resources' do
  let(:resources_name) { described_class.name.split("::").last.downcase.pluralize }
  let(:collection) { described_class.all }

  before { VCR.insert_cassette("resources/#{resources_name}") }

  after { VCR.eject_cassette }

  it { expect(collection).to be_a(ActiveResource::Collection) }
  it { expect(collection.count).to be > 0 }
  it { expect(collection.first).to be_a(described_class) }
end

shared_examples 'api resource' do |res_id|
  let(:resource_name) { described_class.name.split("::").last.downcase }
  let(:resource_id) { res_id }
  let(:resource) { build(resource_name, id: resource_id) }

  before { VCR.insert_cassette("resources/#{resource_name}") }

  after { VCR.eject_cassette }

  describe "#update_attributes_from_api!" do
    def perform
      resource.update_attributes_from_api!
    end

    it { expect(perform).to eq(true) }

    it "updates resource with expected api data" do
      expect(resource).not_to have_attributes(resource_changes)
      perform
      expect(resource.reload).to have_attributes(resource_changes)
    end

    context "with blank resource id" do
      let(:resource_id) { nil }

      it { expect { perform }.to raise_error("can't update resource without id") }
    end

    context "with existent resource" do
      let(:resource) { create(resource_name, id: resource_id) }

      it { expect(perform).to eq(true) }
    end
  end
end
