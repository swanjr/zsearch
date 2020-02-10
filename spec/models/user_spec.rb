# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:organization).optional(true) }
  end

  context 'with validations' do
    subject { FactoryBot.build(:user) }

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

  describe '.searchable_fields' do
    it 'returns fields that can be searched on' do
      expect(described_class.column_names.map(&:to_sym)).to include(*described_class.searchable_fields)
    end

    it 'to not return internal ids' do
      expect(described_class.searchable_fields).not_to include(:_id, :organization_id)
    end
  end

  describe '.search' do
    let!(:bob) { FactoryBot.create(:user, name: 'Bob', tags: 'hello world') }
    let!(:julia) { FactoryBot.create(:user, name: 'Julia') }

    it 'returns users matching the provided column/values pairs' do
      users = described_class.search(name: julia.name)
      expect(users.count).to be(1)
      expect(users.first.name).to eq(julia.name)
    end

    it 'returns organization information for users' do
      users = described_class.search(name: bob.name)
      expect(users.first.organization).not_to be_nil
      expect(users.first.organization.name).not_to be_blank
    end

    it 'returns users matching a tag' do
      users = described_class.search(tags: 'hello')
      expect(users.count).to be(1)
      expect(users.first.name).to eq(bob.name)
    end
  end
end
