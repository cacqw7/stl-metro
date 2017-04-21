class Route < ApplicationRecord
  has_many :trips, primary_key: 'route_id'

  validates_presence_of :route_short_name,
                        :route_long_name,
                        :route_type
end
