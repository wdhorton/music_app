class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :recorded

      t.timestamps
    end

    add_index :albums, :band_id

    add_column :tracks, :kind, :string
  end
end
