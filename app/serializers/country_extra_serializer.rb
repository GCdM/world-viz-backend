class CountryExtraSerializer < ActiveModel::Serializer

  attributes :countries_extra_data

  def countries_extra_data
       
      object
      # Country.all.each do |country|
        # newObj[country.name] = {
        #   total_immigration: {
        #     "1990": country.positive_flow_by(1990),
        #     "1995": country.positive_flow_by(1995),
        #     "2000": country.positive_flow_by(2000),
        #     "2005": country.positive_flow_by(2005),
        #     "2010": country.positive_flow_by(2010),
        #     "2015": country.positive_flow_by(2015),
        #     "2017": country.positive_flow_by(2017)
        #   },
        #   total_emigration: {
        #     "1990": country.negative_flow_by(1990),
        #     "1995": country.negative_flow_by(1995),
        #     "2000": country.negative_flow_by(2000),
        #     "2005": country.negative_flow_by(2005),
        #     "2010": country.negative_flow_by(2010),
        #     "2015": country.negative_flow_by(2015),
        #     "2017": country.negative_flow_by(2017)
        #   },
        #   net_migration: {
        #     "1990": country.net_flow_by(1990),
        #     "1995": country.net_flow_by(1995),
        #     "2000": country.net_flow_by(2000),
        #     "2005": country.net_flow_by(2005),
        #     "2010": country.net_flow_by(2010),
        #     "2015": country.net_flow_by(2015),
        #     "2017": country.net_flow_by(2017)
        #   }
        # }
  end
end
