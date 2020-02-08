# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
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
end
