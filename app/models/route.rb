class Route < ApplicationRecord
  has_many :trips, primary_key: 'route_id'
end
