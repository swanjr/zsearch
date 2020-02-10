# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/search/new'
      expect(response).to be_successful
      expect(response.body).to include('Search For')
    end
  end

  describe 'POST /create' do
    it 'successfully returns results' do
      user = FactoryBot.create(:user)
      post '/search', params: { search: {
        query: "name:#{user.name}", type: 'user'
      } }

      expect(response).to be_successful
      expect(response.body).to include("Name: #{user.name}")
    end

    it 'returns success if no results found' do
      post '/search', params: { search: {
        query: 'name:fake name', type: 'user'
      } }

      expect(response).to be_successful
      expect(response.body).to include('No results found')
    end

    it 'returns success if search query is invalid' do
      post '/search', params: { search: {
        query: 'search text', type: 'fake_type'
      } }

      expect(response).to be_successful
      expect(response.body).to include('Type is not included')
    end
  end
end
