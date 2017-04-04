class CreateShapes < ActiveRecord::Migration[5.1]
  def change
    create_table :shapes do |t|
      t.string :shape_id
      t.decimal :shape_pt_lat, presence: true, precision: 10, scale: 6
      t.decimal :shape_pt_lon, presence: true, precision: 10, scale: 6
      t.integer :shape_pt_sequence, presence: true, numericability: { only_integer: true, greater_than_or_equal_to: 0 }
      t.decimal :shape_dist_traveled, numericability: { greater_than_or_equal_to: 0 }

      t.timestamps
    end
  end
end
