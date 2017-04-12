class CreateStopTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :stop_times do |t|
      t.string :trip_id
      t.integer :arrival_hour
      t.integer :arrival_minute
      t.integer :arrival_second
      t.integer :departure_hour
      t.integer :departure_minute
      t.integer :departure_second
      t.string :stop_id
      t.integer :stop_sequence
      t.string :stop_headsign
      t.integer :pickup_type, default: 0
      t.integer :drop_off_type, default: 0
      t.decimal :shape_dist_traveled
      t.decimal :timepoint

      t.timestamps
    end

    add_index :stop_times, :trip_id
    add_index :stop_times, :stop_id
  end
end
