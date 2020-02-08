# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    sequence(:_id) { |n| n }
    sequence(:url) { |_n| "http://#{Faker::Internet.unique.domain_word}.zendesk.com/api/v2/organizations/#{_id}.json" }
    external_id { SecureRandom.uuid }
    name { Faker::Name.name }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
