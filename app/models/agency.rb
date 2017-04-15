class Agency < ApplicationRecord
  validates_presence_of :agency_name,
                        :agency_url,
                        :agency_timezone
end
