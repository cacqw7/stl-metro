class Stop < ApplicationRecord
  has_many :stop_times, primary_key: 'stop_id'
  has_many :trips, through: :stop_times

  validates_presence_of :stop_name,
                        :stop_latlon

  attr_reader :now

  def departures
    upcoming.reduce([]) do |departures, stop_time|
      departures << [stop_time, stop_time.route]
    end
  end

  def upcoming
    stop_times.where('departure_hour >= ?', now.hour)
              .select { |st| st.available? }
              .sort_by { |e| [e.departure_hour, e.departure_minute] }
  end

  def now
    @now ||= DateTime.now
  end
end
