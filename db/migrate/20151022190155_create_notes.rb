class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :notes, :user_id
  end
end
