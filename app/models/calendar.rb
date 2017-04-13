class Calendar < ApplicationRecord
  has_many :calendar_dates, foreign_key: 'service_id', primary_key: 'service_id'
end
