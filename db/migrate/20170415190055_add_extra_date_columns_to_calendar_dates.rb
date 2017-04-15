class AddExtraDateColumnsToCalendarDates < ActiveRecord::Migration[5.1]
  def change
    add_column :calendar_dates, :date_hour, :integer, required: true
    add_column :calendar_dates, :date_minute, :integer, required: true
    add_column :calendar_dates, :date_second, :integer, required: true
  end
end
