# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    sequence(:_id) { |n| n }
    sequence(:url) { |_n| "http://#{Faker::Internet.unique.domain_word}.zendesk.com/api/v2/tickets/#{_id}.json" }
    external_id { SecureRandom.uuid }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    subject { 'Something broke' }

    association :submitter, factory: :user
    association :assignee, factory: :user
    association :organization
  end
end
