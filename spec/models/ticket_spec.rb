# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:organization).optional(true) }
    it { is_expected.to belong_to(:submitter).with_foreign_key('submitter_id').optional(true) }
    it { is_expected.to belong_to(:assignee).with_foreign_key('assignee_id').optional(true) }
  end

  context 'with validations' do
    subject { FactoryBot.build(:ticket) }

    it { is_expected.to validate_presence_of(:_id) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:created_at) }

    it { is_expected.to validate_uniqueness_of(:_id).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:url).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:external_id).ignoring_case_sensitivity }
  end

  describe '.searchable_fields' do
    it 'returns fields that can be searched on' do
      expect(described_class.column_names.map(&:to_sym)).to include(*described_class.searchable_fields)
    end

    it 'to not return internal ids' do
      expect(described_class.searchable_fields).not_to include(:_id, :organization_id, :submitter_id, :assignee_id)
    end
  end

  describe '.search' do
    let!(:ticket_1) { FactoryBot.create(:ticket, subject: 'Power outage') }
    let!(:ticket_2) { FactoryBot.create(:ticket, subject: 'Computer locked', tags: 'plug out') }
    let(:results) { described_class.search(subject: ticket_1.subject) }

    it 'returns tickets matching the provided column/values pairs' do
      expect(results.count).to be(1)
      expect(results.first.subject).to eq(ticket_1.subject)
    end

    it 'returns submitter information for tickets' do
      expect(results.first.submitter.name).to eq(ticket_1.submitter.name)
    end

    it 'returns assignee information for tickets' do
      expect(results.first.assignee.name).to eq(ticket_1.assignee.name)
    end

    it 'returns organization information for tickets' do
      expect(results.first.organization.name).to eq(ticket_1.organization.name)
    end

    it 'returns tickets matching a tag' do
      tickets = described_class.search(tags: 'out')
      expect(tickets.count).to be(1)
      expect(tickets.first.subject).to eq(ticket_2.subject)
    end
  end
end
