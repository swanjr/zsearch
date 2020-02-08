# frozen_string_literal: true

class Organization < ApplicationRecord
  self.primary_key = :_id

  validates :_id, :url, :external_id, :name,
            uniqueness: { case_sensitive: false }
  validates :_id, :url, :external_id, :name, :created_at,
            presence: true
end
