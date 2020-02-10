# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Load organizations into db
path = File.join(File.dirname(__FILE__), "data/organizations.json")
JSON.parse(File.read(path)).each do |data|
  # Convert domains list to a String
  domains = data.fetch('domain_names', "")
  data['domain_names'] = domains.join(' ')  

  # Convert tags list to a String
  tags = data.fetch('tags', "")
  data['tags'] = tags.join(' ')  

  Organization.create!(data)
end

# Load users into db
path = File.join(File.dirname(__FILE__), "data/users.json")
JSON.parse(File.read(path)).each do |data|
  # Remove bad organization_ids where the Organization doesn't exist
  if data.key?('organization_id') && !Organization.exists?(data['organization_id'])
    puts "Removing bad organization_id '#{data['organization_id']} from User '#{data['_id']}'. Organization does not exist."
    data.delete('organization_id')
  end

  # Convert tags list to a String
  tags = data.fetch('tags', "")
  data['tags'] = tags.join(' ')  

  User.create!(data)
end

# Load tickets into db
path = File.join(File.dirname(__FILE__), "data/tickets.json")
JSON.parse(File.read(path)).each do |data|
  # Remove organization_ids where the Organization doesn't exist
  if data.key?('organization_id') && !Organization.exists?(data['organization_id'])
    puts "Removing bad organization_id '#{data['organization_id']} from Ticket '#{data['_id']}'. Organization does not exist."
    data.delete('organization_id')
  end
  # Remove bad submitter_ids where the User doesn't exist
  if data.key?('submitter_id') && !User.exists?(data['submitter_id'])
    puts "Removing bad submitter_id '#{data['submitter_id']} from Ticket '#{data['_id']}'. User does not exist."
    data.delete('submitter_id')
  end
  # Remove bad assignee_ids where the User doesn't exist
  if data.key?('assignee_id') && !User.exists?(data['assignee_id'])
    puts "Removing bad assignee_id '#{data['assignee_id']} from Ticket '#{data['_id']}'. User does not exist."
    data.delete('assignee_id')
  end

  # Convert tags list to a String
  tags = data.fetch('tags', "")
  data['tags'] = tags.join(' ')  

  Ticket.create!(data)
end
