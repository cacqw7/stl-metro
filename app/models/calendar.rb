class Calendar < ApplicationRecord
  has_many :calendar_dates, foreign_key: 'service_id', primary_key: 'service_id'

  validates_presence_of :start_date,
                        :end_date,
                        :monday,
                        :tuesday,
                        :wednesday,
                        :thursday,
                        :friday,
                        :saturday,
                        :sunday

  attr_reader :now

  def available?
    public_send(day_of_week) == 1 &&
    start_date <= now && end_date > now
  end

  def day_of_week
    now.strftime('%A').downcase
  end

  def now
    @now ||= DateTime.now
  end
end
