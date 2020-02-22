# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search', type: :system do
  it 'home page displays a search form' do
    visit '/'
    expect(page).to have_field('search_query', type: 'text')
    expect(page).to have_button('Search')
  end

  context 'when searching users' do
    let!(:users) { FactoryBot.create_list(:user_with_tickets, 2) }

    it 'displays users matching the query' do
      visit '/'
      find_field('search_query')

      fill_in 'search_query', with: "name:#{users.first.name}"
      choose 'search_type_user'

      click_button 'Search'

      expect(page).to have_text("Name: #{users.first.name}")
      expect(page).to have_text("Organization: #{users.first.organization.name}")
      expect(page).to have_text(users.first.submitted_tickets.last.subject.to_s)
      expect(page).to have_text(users.first.assigned_tickets.last.subject.to_s)
      expect(page).not_to have_text("Name: #{users.second.name}")
    end
  end

  context 'when searching organizations' do
    let!(:organizations) { FactoryBot.create_list(:organization_with_users_and_tickets, 2) }

    it 'displays organizations matching the query' do
      visit '/'
      find_field('search_query')

      fill_in 'search_query', with: "name:#{organizations.first.name}"
      choose 'search_type_organization'

      click_button 'Search'

      expect(page).to have_text("Name: #{organizations.first.name}")
      expect(page).to have_text(organizations.first.users.last.name.to_s)
      expect(page).not_to have_text("Name: #{organizations.second.name}")
      expect(page).to have_text("Ticket Status: ")
      organizations.first.tickets.each do 
        expect(page).to have_text("Open (1), Closed (2)")
      end
    end
  end

  context 'when searching tickets' do
    let!(:tickets) { FactoryBot.create_list(:ticket, 2) }

    it 'displays tickets matching the query' do
      visit '/'
      find_field('search_query')

      fill_in 'search_query', with: "subject:#{tickets.first.subject}"
      choose 'search_type_ticket'

      click_button 'Search'

      expect(page).to have_text("Subject: #{tickets.first.subject}")
      expect(page).to have_text("Organization: #{tickets.first.organization.name}")
      expect(page).to have_text("Submitted By: #{tickets.first.submitter.name}")
      expect(page).to have_text("Assigned To: #{tickets.first.assignee.name}")
      expect(page).not_to have_text("Subject: #{tickets.second.subject}")
    end
  end
end
