# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search, type: :model do
  let(:search) { described_class.new(query: 'name:John Doe', type: 'user') }

  context 'with validations' do
    it { is_expected.to validate_presence_of(:query) }

    it { is_expected.to validate_inclusion_of(:type).in_array(Search::VALID_TYPES) }
  end

  describe '#run' do
    it 'validates query fields are valid' do
      search = described_class.new(query: 'name:Jim,tree:apple', type: 'user')
      search.run

      expect(search.errors[:tree]).to include('is not a valid search field')
    end

    it "calls the specified model's search with a constructured criteria hash" do
      expect(User).to receive(:search).with(name: 'John Doe')
      search.run
    end
  end

  describe '#results' do
    it "returns an empty array if 'run' hasn't been called" do
      expect(search.results).to eq([])
    end

    it 'returns an empty array if search is invalid' do
      search.query = nil
      search.run
      expect(search.results).to eq([])
    end

    it 'returns an empty array if query has no fields' do
      search.query = ':'
      search.run
      expect(search.results).to eq([])
    end

    it "returns the model's search results if 'run' has been called" do
      user = User.new(name: 'Bob')
      allow(User).to receive(:search).and_return([user])
      search.run
      expect(search.results).to eq([user])
    end
  end

  describe '#available_fields' do
    let(:mock_fields) { %i[url name] }

    it 'returns a hash of field that can be searched on' do
      expected_hash = {}
      Search::VALID_TYPES.each do |type|
        expected_hash[type.to_sym] = mock_fields
        allow(type.classify.constantize).to receive(:searchable_fields).and_return(mock_fields)
      end
      expect(search.available_fields).to eq(expected_hash)
    end
  end
end
