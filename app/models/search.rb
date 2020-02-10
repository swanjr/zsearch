# frozen_string_literal: true

class Search
  include ActiveModel::Model

  FIELD_DELIMITER = ','
  KV_DELIMITER = ':'
  VALID_TYPES = ['user'].freeze

  attr_accessor :query, :type

  validates :query, presence: true
  validates :type, inclusion: { in: VALID_TYPES }, allow_blank: false

  def run
    return if invalid?

    criteria = parse_query
    return unless valid_query_fields?(criteria)

    model_clazz = type.classify.constantize
    @results = model_clazz.search criteria
  end

  def results
    @results ||= []
  end

  def available_fields
    available_fields = {}
    VALID_TYPES.each do |type|
      model_clazz = type.classify.constantize
      available_fields[type.to_sym] = model_clazz.searchable_fields
    end
    available_fields
  end

  private

  def parse_query
    criteria = {}

    # Decompose query into a hash
    pairs = query.split(FIELD_DELIMITER)
    pairs.each do |pair|
      kv = pair.split(KV_DELIMITER)
      # Include '' string in "no value" searches
      criteria[kv[0].to_sym] = kv[1] || [nil, '']
    end
    criteria
  end

  def valid_query_fields?(criteria)
    return false if criteria.blank?

    model_clazz = type.classify.constantize
    (criteria.keys - model_clazz.searchable_fields).each do |field|
      errors.add(field, 'is not a valid search field')
    end

    errors.empty?
  end
end
