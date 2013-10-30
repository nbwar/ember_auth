class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.belongs_to :user, index: true
      t.string :access_token
      t.string :scope
      t.datetime :expired_at
      t.datetime :create_at

      t.timestamps
    end
    add_index :api_keys, :access_token, unique: true
  end
end
