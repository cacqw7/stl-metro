class StopTime < ApplicationRecord
  belongs_to :trip, primary_key: 'trip_id'
  belongs_to :stop, primary_key: 'stop_id'
  has_many :calendars, through: :trip
  has_many :calendar_dates, through: :trip
  has_one :route, through: :trip

  validates_presence_of :arrival_hour,
                        :arrival_minute,
                        :arrival_second,
                        :departure_hour,
                        :departure_minute,
                        :departure_second,
                        :stop_id,
                        :stop_sequence

  attr_reader :now

  def departure_time
    DateTime.parse("#{departure_hour % 24}:#{departure_minute} CDT")
  end

  def available?
    return false if in_the_past?
    trip.calendars.any? { |calendar| calendar.available? }
  end

  def in_the_past?
    departure_hour < now.hour ||
    (departure_hour == now.hour &&
    departure_minute < now.minute)
  end

  def now
    @now ||= DateTime.now
  end
end
