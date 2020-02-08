class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations, id: false do |t|
      t.integer :_id, null: false, primary_key: true
      t.string :url, null: false, index: {unique: true}
      t.string :external_id, null: false, index: {unique: true}
      t.string :name, null: false, index: {unique: true}
      t.text :domain_names
      t.datetime :created_at, null: false
      t.string :details
      t.boolean :shared_tickets
      t.text :tags
    end
  end
end
