class AddTimestampDefaults < ActiveRecord::Migration[5.0]
  def change
    %w(stops agencies calendar_dates calendars routes shapes stop_times stops trips).each do |table_name|
      change_column_default table_name, :created_at, from: nil, to: -> { 'CURRENT_TIMESTAMP' }
      change_column_default table_name, :updated_at, from: nil, to: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
