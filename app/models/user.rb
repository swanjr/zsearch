# frozen_string_literal: true

class User < ApplicationRecord
  self.primary_key = :_id

  belongs_to :organization, optional: true

  validates :_id, :url, :external_id, :name,
            uniqueness: { case_sensitive: false }
  validates :_id, :url, :external_id, :name, :created_at,
            presence: true

  def self.searchable_fields
    fields = User.column_names.map(&:to_sym)
    # Internal ids and should not be exposed to the user
    fields - %i[_id organization_id]
  end

  def self.search(criteria)
    User.includes(:organization).where(criteria)
  end
end
