class Shape < ApplicationRecord
  has_many :trips, primary_key: 'shape_id', foreign_key: 'shape_id'

  validates_presence_of :shape_pt_lat,
                        :shape_pt_lon,
                        :shape_pt_sequence
end
