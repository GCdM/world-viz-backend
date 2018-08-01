class CountrySerializer < ActiveModel::Serializer

  attributes :country_data

  def country_data
    {
      name: object.name,
      high_income: object.high_income,
      upper_middle_income: object.upper_middle_income,
      middle_income: object.middle_income,
      lower_middle_income: object.lower_middle_income,
      low_income: object.low_income,
      emigrations: self.emigration_info,
      immigrations: self.immigration_info
    }
  end

  def emigration_info
    info = {}
    object.emigrations.each do |flow|
      info[flow.destination.name] ||= {}
      info[flow.destination.name]['country_name'] = flow.destination.name
      info[flow.destination.name]['info'] = {
        high_income: flow.destination.high_income,
        upper_middle_income: flow.destination.upper_middle_income,
        middle_income: flow.destination.middle_income,
        lower_middle_income: flow.destination.lower_middle_income,
        low_income: flow.destination.low_income
      }
      info[flow.destination.name]['data'] ||= {}
      info[flow.destination.name]['data'][flow.year] = flow.quantity
    end
    results = []
    info.each do |k, v|
      results << v
    end

    results
  end

  def immigration_info
    info = {}
    object.immigrations.each do |flow|
      info[flow.origin.name] ||= {}
      info[flow.origin.name]['country_name'] = flow.origin.name
      info[flow.origin.name]['info'] = {
        high_income: flow.origin.high_income,
        upper_middle_income: flow.origin.upper_middle_income,
        middle_income: flow.origin.middle_income,
        lower_middle_income: flow.origin.lower_middle_income,
        low_income: flow.origin.low_income
      }
      info[flow.origin.name]['data'] ||= {}
      info[flow.origin.name]['data'][flow.year] = flow.quantity
    end
    results = []
    info.each do |k, v|
      results << v
    end

    results
  end
end
