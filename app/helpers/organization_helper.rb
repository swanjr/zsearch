module OrganizationHelper
  def ticket_counts(organization)
    ticket_counts_str = ''
    organization.ticket_count_by_status.each do |status, count|
      ticket_counts_str += "#{status.capitalize} (#{count}), "
    end
    ticket_counts_str.delete_suffix(', ')
  end
end
