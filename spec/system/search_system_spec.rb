# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search', type: :system do
  it 'home page displays a search form' do
    visit '/'
    expect(page).to have_field('search_query', type: 'text')
    expect(page).to have_button('Search')
  end

  context 'when searching users' do
    let!(:users) { FactoryBot.create_list(:user, 3) }

    it 'displays users matching the query' do
      visit '/'
      find_field('search_query')

      fill_in 'search_query', with: "name:#{users[1].name}"
      choose 'search_type_user'

      click_button 'Search'

      expect(page).not_to have_text('No results found')
      expect(page).to have_text("Name: #{users[1].name}")
    end
  end
end
