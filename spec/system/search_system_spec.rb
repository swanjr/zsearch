# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search', type: :system do
  it 'home page displays a search form' do
    visit '/'
    expect(page).to have_field('search_query', type: 'text')
    expect(page).to have_button('Search')
  end
end
