# frozen_string_literal: true

class User < ApplicationRecord
  self.primary_key = :_id

  belongs_to :organization, optional: true

  validates :_id, :url, :external_id, :name,
            uniqueness: { case_sensitive: false }
  validates :_id, :url, :external_id, :name, :created_at,
            presence: true
end
