class Calendar < ApplicationRecord
  has_many :calendar_dates, foreign_key: 'service_id', primary_key: 'service_id'

  validates_presence_of :start_date_hour,
                        :start_date_minute,
                        :start_date_second,
                        :end_date_hour,
                        :end_date_minute,
                        :end_date_second,
                        :monday,
                        :tuesday,
                        :wednesday,
                        :thursday,
                        :friday,
                        :saturday,
                        :sunday
end
