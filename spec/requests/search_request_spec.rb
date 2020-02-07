# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/search/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'returns http success' do
      post '/search', params: { search: { query: 'search text' } }
      expect(response).to have_http_status(:success)
    end
  end
end
