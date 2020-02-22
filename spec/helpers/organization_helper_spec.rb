# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationHelper, :type => :helper do
  describe "#ticket_counts" do
    it "displays number of tickets per status" do
      org = FactoryBot.create(:organization_with_users_and_tickets)

      expect(helper.ticket_counts(org)).to eq("Open (1), Closed (2)")
    end
  end
end
