# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:_id) { |n| (User.last.try(:_id) || 0).to_i + 1 }
    sequence(:url) { |_n| "http://#{Faker::Internet.unique.domain_word}.zendesk.com/api/v2/users/#{_id}.json" }
    external_id { SecureRandom.uuid }
    name { Faker::Name.name }
    self.alias { 'MyString' }
    tags { Faker::Lorem.unique.words(number: 3).join(' ') }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }

    association :organization

    factory :user_with_tickets do
      transient do
        ticket_count { 2 }
      end

      after(:create) do |user, evaluator|
        create_list(:ticket, evaluator.ticket_count, submitter: user)
        create_list(:ticket, evaluator.ticket_count, assignee: user)
      end
    end
  end
end
