class CountryIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :high_income, :upper_middle_income, :middle_income, :lower_middle_income, :low_income
end
