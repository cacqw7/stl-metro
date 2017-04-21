class CreateShapes < ActiveRecord::Migration[5.0]
  def change
    create_table :shapes do |t|
      t.string :shape_id
      t.st_point :shape_pt_latlon, geographic: true, presence: true
      t.integer :shape_pt_sequence, presence: true, numericability: { only_integer: true, greater_than_or_equal_to: 0 }
      t.decimal :shape_dist_traveled, numericability: { greater_than_or_equal_to: 0 }

      t.timestamps
    end
  end
end
