class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :trip_id
      t.string :route_id
      t.string :service_id
      t.string :trip_headsign
      t.string :trip_short_name
      t.integer :direction_id
      t.string :block_id
      t.string :shape_id
      t.integer :wheelchair_accesible, default: 0
      t.integer :bikes_allowed, default: 0

      t.timestamps
    end
  end
end
