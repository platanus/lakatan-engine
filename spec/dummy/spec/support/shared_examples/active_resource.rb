# frozen_string_literal: true

shared_examples 'find resource' do |res_id|
  let(:resource_name) { described_class.name.split("::").last.downcase }
  let(:resource_id) { res_id }
  let(:resource) { described_class.find(resource_id) }

  before { VCR.insert_cassette("resources/#{resource_name}") }

  after { VCR.eject_cassette }

  it { expect(resource).to be_a(described_class) }
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
