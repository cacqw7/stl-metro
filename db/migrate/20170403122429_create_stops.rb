class CreateStops < ActiveRecord::Migration[5.1]
  def change
    create_table :stops do |t|
      t.string :stop_id
      t.string :stop_code
      t.string :stop_name
      t.text :stop_desc
      t.decimal :stop_lat, precision: 10, scale: 6
      t.decimal :stop_lon, precision: 10, scale: 6
      t.string :zone_id, null: true
      t.string :stop_url
      t.integer :location_type, default: 0
      t.string :parent_station
      t.string :timezone
      t.integer :wheelchair_boarding

      t.timestamps
    end
  end
end
