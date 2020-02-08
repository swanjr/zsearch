class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets, id: false do |t|
      t.string :_id, null: false, primary_key: true
      t.string :url, null: false, index: {unique: true}
      t.string :external_id, null: false, index: {unique: true}
      t.datetime :created_at, null: false
      t.string :type
      t.string :subject, null: false
      t.text :description
      t.string :priority
      t.string :status
      t.belongs_to :submitter, type: :integer, index: true, 
                   foreign_key: {to_table: :users, primary_key: :_id}
      t.belongs_to :assignee, type: :integer, index: true, 
                   foreign_key: {to_table: :users, primary_key: :_id}
      t.belongs_to :organization, type: :integer, index: true,
                   foreign_key: {primary_key: :_id}
      t.text :tags
      t.boolean :has_incidents
      t.datetime :due_at
      t.string :via
    end
  end
end
