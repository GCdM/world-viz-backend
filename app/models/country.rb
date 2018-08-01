class Country < ApplicationRecord
  has_many :emigrations, class_name: "Flow", foreign_key: "origin_id"
  has_many :immigrations, class_name: "Flow", foreign_key: "destination_id"

  has_many :emigration_countries, through: :emigrations, class_name: "Country", source: "destination"
  has_many :immigration_countries, through: :immigrations, class_name: "Country", source: "origin"
end
