class AddSessionTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string, null: false, unique: true
    add_index :users, :session_token
  end
end
