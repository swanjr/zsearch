# frozen_string_literal: true

class User < ApplicationRecord
  self.primary_key = :_id

  belongs_to :organization, optional: true
  has_many :submitted_tickets,
           inverse_of: 'submitter',
           foreign_key: 'submitter_id',
           class_name: 'Ticket',
           dependent: :nullify
  has_many :assigned_tickets,
           inverse_of: 'assignee',
           foreign_key: 'assignee_id',
           class_name: 'Ticket',
           dependent: :nullify

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
    relation = User.includes(:organization)

    tags = criteria.delete(:tags)
    if tags.present?
      tags.split(' ').each do |tag|
        relation = relation.where('tags LIKE ?', "%#{tag}%")
      end
    end

    relation = relation.where(criteria)
  end
end
