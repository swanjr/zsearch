# frozen_string_literal: true

class Ticket < ApplicationRecord
  self.primary_key = :_id

  # Override so we can have a column named 'type' without Rails
  # expecting it will be used for inheritance
  self.inheritance_column = 'class_type'

  belongs_to :organization,
             optional: true
  belongs_to :submitter,
             class_name: 'User',
             foreign_key: :submitter_id,
             inverse_of: false,
             optional: true
  belongs_to :assignee,
             class_name: 'User',
             foreign_key: :assignee_id,
             inverse_of: false,
             optional: true

  validates :_id, :url, :external_id,
            uniqueness: { case_sensitive: false }
  validates :_id, :url, :external_id, :subject, :created_at,
            presence: true
end
