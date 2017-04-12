class Stop < ApplicationRecord
  has_many :stop_times, primary_key: 'stop_id'
end
