class AddTrackIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :track_id, :integer, null: false
    add_index :notes, :track_id
  end
end
