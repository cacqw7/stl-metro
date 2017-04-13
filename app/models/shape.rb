class Shape < ApplicationRecord
  has_many :trips, primary_key: 'shape_id', foreign_key: 'shape_id'
end
