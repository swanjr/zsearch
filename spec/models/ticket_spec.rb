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
end
