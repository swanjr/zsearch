# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    sequence(:_id) { |n| n }
    sequence(:url) { |_n| "http://#{Faker::Internet.unique.domain_word}.zendesk.com/api/v2/organizations/#{_id}.json" }
    external_id { SecureRandom.uuid }
    name { Faker::Name.name }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    tags { Faker::Lorem.unique.words(number: 3).join(' ') }
    domain_names { Faker::Lorem.unique.words(number: 4).join(' ') }

    factory :organization_with_users do
      transient do
        user_count { 2 }
      end

      after(:create) do |organization, evaluator|
        create_list(:user, evaluator.user_count, organization: organization)
      end
    end
  end
end
