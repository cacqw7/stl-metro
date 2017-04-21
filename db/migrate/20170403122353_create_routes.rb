class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.string :route_id, presence: true
      t.string :agency_id
      t.string :route_short_name, presence: true
      t.string :route_long_name, presence: true
      t.string :route_desc
      t.string :route_type, presence: true
      t.string :route_url
      t.string :route_color
      t.string :route_text_color

      t.timestamps
    end
  end
end
