class CreateAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :agencies do |t|
      t.string :agency_id
      t.string :agency_name, presence: true
      t.string :agency_url, presence: true
      t.string :agency_timezone, presence: true
      t.string :agency_lang
      t.string :agency_phone
      t.string :agency_fare_url
      t.string :agency_email

      t.timestamps
    end
  end
end
