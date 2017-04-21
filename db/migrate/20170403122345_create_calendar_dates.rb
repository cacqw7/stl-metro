class CreateCalendarDates < ActiveRecord::Migration[5.0]
  def change
    create_table :calendar_dates do |t|
      t.string :service_id, presence: true
      t.datetime :date, presence: true
      t.integer :exception_type, presence: true

      t.timestamps
    end
  end
end
