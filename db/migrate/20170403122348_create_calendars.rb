class CreateCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :calendars do |t|
      t.string :service_id, presence: true
      t.integer :monday, presence: true
      t.integer :tuesday, presence: true
      t.integer :wednesday, presence: true
      t.integer :thursday, presence: true
      t.integer :friday, presence: true
      t.integer :saturday, presence: true
      t.integer :sunday, presence: true
      t.datetime :start_date, presence: true
      t.datetime :end_date, presence: true

      t.timestamps
    end
  end
end
