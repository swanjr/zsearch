# frozen_string_literal: true

class Organization < ApplicationRecord
  self.primary_key = :_id

  has_many :users, dependent: :destroy
  has_many :tickets, dependent: :destroy

  validates :_id, :url, :external_id, :name,
            uniqueness: { case_sensitive: false }
  validates :_id, :url, :external_id, :name, :created_at,
            presence: true

  def ticket_count_by_status
    tickets.group(:status).count
  end

  def self.searchable_fields
    fields = Organization.column_names.map(&:to_sym)
    # Internal ids and should not be exposed to the user
    fields - %i[_id]
  end

  def self.search(criteria)
    relation = Organization.includes(:users, :tickets)

    tags = criteria.delete(:tags)
    if tags.present?
      tags.split(' ').each do |tag|
        relation = relation.where('tags LIKE ?', "%#{tag}%")
      end
    end

    domains = criteria.delete(:domain_names)
    if domains.present?
      domains.split(' ').each do |domain|
        relation = relation.where('domain_names LIKE ?', "%#{domain}%")
      end
    end

    relation = relation.where(criteria)
  end
end
