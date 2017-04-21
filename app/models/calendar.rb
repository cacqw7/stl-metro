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
end
