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

  def self.searchable_fields
    fields = Ticket.column_names.map(&:to_sym)
    # Internal ids and should not be exposed to the user
    fields - %i[_id organization_id submitter_id assignee_id]
  end

  def self.search(criteria)
    Ticket.includes(:organization, :submitter, :assignee).where(criteria)
  end
end
