class CalendarDate < ApplicationRecord
  belongs_to :calendar, foreign_key: 'service_id', primary_key: 'service_id'
end
