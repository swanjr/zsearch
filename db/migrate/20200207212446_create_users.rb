class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false do |t|
      t.integer :_id, null: false, primary_key: true
      t.string :url, null: false, index: {unique: true}
      t.string :external_id, null: false, index: {unique: true}
      t.string :name, null: false, index: {unique: true}
      t.string :alias
      t.datetime :created_at, null: false
      t.boolean :active
      t.boolean :verified
      t.boolean :shared
      t.string :locale
      t.string :timezone
      t.datetime :last_login_at
      t.string :email
      t.string :phone
      t.string :signature
      t.belongs_to :organization, type: :integer, index: true,
                   foreign_key: {primary_key: :_id}
      t.text :tags
      t.boolean :suspended
      t.string :role
    end
  end
end
