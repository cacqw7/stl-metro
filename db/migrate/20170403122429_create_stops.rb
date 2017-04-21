class CreateStops < ActiveRecord::Migration[5.0]
  def change
    create_table :stops do |t|
      t.string :stop_id
      t.string :stop_code
      t.string :stop_name
      t.text :stop_desc
      t.st_point :stop_latlon, geographic: true
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
