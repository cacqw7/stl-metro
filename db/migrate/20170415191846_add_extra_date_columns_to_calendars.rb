class AddExtraDateColumnsToCalendars < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars, :start_date_hour, :integer, required: true
    add_column :calendars, :start_date_minute, :integer, required: true
    add_column :calendars, :start_date_second, :integer, required: true

    add_column :calendars, :end_date_hour, :integer, required: true
    add_column :calendars, :end_date_minute, :integer, required: true
    add_column :calendars, :end_date_second, :integer, required: true
  end
end
