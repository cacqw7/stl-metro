class Stop < ApplicationRecord
  has_many :stop_times, primary_key: 'stop_id'

  validates_presence_of :stop_name,
                        :stop_latlon
end
