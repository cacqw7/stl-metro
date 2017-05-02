class Trip < ApplicationRecord
  belongs_to :route, primary_key: 'route_id'
  has_many :shapes, foreign_key: 'shape_id', primary_key: 'shape_id'
  has_many :stop_times, primary_key: 'trip_id'
  has_many :calendars, foreign_key: 'service_id', primary_key: 'service_id'
  has_many :calendar_dates, foreign_key: 'service_id', primary_key: 'service_id'
end
