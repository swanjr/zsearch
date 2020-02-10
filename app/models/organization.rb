# frozen_string_literal: true

class Organization < ApplicationRecord
  self.primary_key = :_id

  has_many :users, dependent: :destroy

  validates :_id, :url, :external_id, :name,
            uniqueness: { case_sensitive: false }
  validates :_id, :url, :external_id, :name, :created_at,
            presence: true

  def self.searchable_fields
    fields = Organization.column_names.map(&:to_sym)
    # Internal ids and should not be exposed to the user
    fields - %i[_id]
  end

  def self.search(criteria)
    Organization.includes(:users).where(criteria)
  end
end
