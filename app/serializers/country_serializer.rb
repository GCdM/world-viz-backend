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
      total_immigration: {
        "1990": object.positive_flow_by(1990),
        "1995": object.positive_flow_by(1995),
        "2000": object.positive_flow_by(2000),
        "2005": object.positive_flow_by(2005),
        "2010": object.positive_flow_by(2010),
        "2015": object.positive_flow_by(2015),
        "2017": object.positive_flow_by(2017)
      },
      total_emigration: {
        "1990": object.negative_flow_by(1990),
        "1995": object.negative_flow_by(1995),
        "2000": object.negative_flow_by(2000),
        "2005": object.negative_flow_by(2005),
        "2010": object.negative_flow_by(2010),
        "2015": object.negative_flow_by(2015),
        "2017": object.negative_flow_by(2017)
      },
      net_migration: {
        "1990": object.net_flow_by(1990),
        "1995": object.net_flow_by(1995),
        "2000": object.net_flow_by(2000),
        "2005": object.net_flow_by(2005),
        "2010": object.net_flow_by(2010),
        "2015": object.net_flow_by(2015),
        "2017": object.net_flow_by(2017)
      },
      emi_by_region: self.emi_region_totals,
      immi_by_region: self.immi_region_totals,
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

  def emi_region_totals
    info = {}
    object.emigrations.each do |flow|
      info[flow.year] ||= {}
      info[flow.year][flow.destination.region] ||= 0
      info[flow.year][flow.destination.region] += flow.quantity
    end
    return info
  end

  def immi_region_totals
    info = {}
    object.immigrations.each do |flow|
      info[flow.year] ||= {}
      info[flow.year][flow.origin.region] ||= 0
      info[flow.year][flow.origin.region] += flow.quantity
    end
    return info
  end
end
