# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
  context 'with associations' do
    it { is_expected.to have_many(:users).dependent(:destroy) }
    it { is_expected.to have_many(:tickets).dependent(:destroy) }
  end

  context 'with validations' do
    subject { FactoryBot.build(:organization) }

    it { is_expected.to validate_presence_of(:_id) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:created_at) }

    it { is_expected.to validate_uniqueness_of(:_id).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:url).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:external_id).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  describe '#ticket_count_by_status' do
    it "returns a hash of statuses with their ticket totals" do
      org = FactoryBot.create(:organization_with_users_and_tickets)

      status_counts = org.ticket_count_by_status
      expect(status_counts).to include('open' => 1, 'closed' => 2)
    end
  end

  describe '.searchable_fields' do
    it 'returns fields that can be searched on' do
      expect(described_class.column_names.map(&:to_sym)).to include(*described_class.searchable_fields)
    end

    it 'to not return internal ids' do
      expect(described_class.searchable_fields).not_to include(:_id)
    end
  end

  describe '.search' do
    let!(:apple) { FactoryBot.create(:organization_with_users, name: 'Apple', domain_names: 'apple.com') }
    let!(:zendesk) { FactoryBot.create(:organization_with_users, name: 'Zendesk', tags: 'zen desk') }

    it 'returns organizations matching the provided column/values pairs' do
      organizations = described_class.search(name: zendesk.name)
      expect(organizations.count).to be(1)
      expect(organizations.first.name).to eq(zendesk.name)
    end

    it 'returns users associated with the organization' do
      organizations = described_class.search(name: apple.name)
      expect(organizations.first.users.count).to be(apple.users.count)
    end

    it 'returns organizations matching a domain' do
      organizations = described_class.search(domain_names: 'apple')
      expect(organizations.count).to be(1)
      expect(organizations.first.name).to eq(apple.name)
    end

    it 'returns organizations matching a tag' do
      organizations = described_class.search(tags: 'zen')
      expect(organizations.count).to be(1)
      expect(organizations.first.name).to eq(zendesk.name)
    end
  end
end
