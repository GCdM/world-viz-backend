class Country < ApplicationRecord
  has_many :emigrations, class_name: "Flow", foreign_key: "origin_id"
  has_many :immigrations, class_name: "Flow", foreign_key: "destination_id"

  has_many :emigration_countries, through: :emigrations, class_name: "Country", source: "destination"
  has_many :immigration_countries, through: :immigrations, class_name: "Country", source: "origin"

  def net_flow_by(year)
    self.positive_flow_by(year) - self.negative_flow_by(year)
  end

  def positive_flow_by(year)
    year_immigrations = self.immigrations.select { |flow| flow.year == year }
    immigration_numbers = year_immigrations.map { |flow| flow.quantity }
    result = immigration_numbers.reduce(:+)
    if !result
      result = 0
    end
    result
  end

  def negative_flow_by(year)
    year_emigrations = self.emigrations.select { |flow| flow.year == year }
    emigration_numbers = year_emigrations.map { |flow| flow.quantity }
    result = emigration_numbers.reduce(:+)
    if !result
      result = 0
    end
    result
  end

  def relationship(extra)
    {
      self.name => {
        total_immigration: {
            "1990": self.positive_flow_by(1990),
            "1995": self.positive_flow_by(1995),
            "2000": self.positive_flow_by(2000),
            "2005": self.positive_flow_by(2005),
            "2010": self.positive_flow_by(2010),
            "2015": self.positive_flow_by(2015),
            "2017": self.positive_flow_by(2017)
          },
          total_emigration: {
            "1990": self.negative_flow_by(1990),
            "1995": self.negative_flow_by(1995),
            "2000": self.negative_flow_by(2000),
            "2005": self.negative_flow_by(2005),
            "2010": self.negative_flow_by(2010),
            "2015": self.negative_flow_by(2015),
            "2017": self.negative_flow_by(2017)
          },
          net_migration: {
            "1990": self.net_flow_by(1990),
            "1995": self.net_flow_by(1995),
            "2000": self.net_flow_by(2000),
            "2005": self.net_flow_by(2005),
            "2010": self.net_flow_by(2010),
            "2015": self.net_flow_by(2015),
            "2017": self.net_flow_by(2017)
          },
          info: self.parse_flows(extra)
      },
      extra.name => {
        total_immigration: {
            "1990": extra.positive_flow_by(1990),
            "1995": extra.positive_flow_by(1995),
            "2000": extra.positive_flow_by(2000),
            "2005": extra.positive_flow_by(2005),
            "2010": extra.positive_flow_by(2010),
            "2015": extra.positive_flow_by(2015),
            "2017": extra.positive_flow_by(2017)
          },
          total_emigration: {
            "1990": extra.negative_flow_by(1990),
            "1995": extra.negative_flow_by(1995),
            "2000": extra.negative_flow_by(2000),
            "2005": extra.negative_flow_by(2005),
            "2010": extra.negative_flow_by(2010),
            "2015": extra.negative_flow_by(2015),
            "2017": extra.negative_flow_by(2017)
          },
          net_migration: {
            "1990": extra.net_flow_by(1990),
            "1995": extra.net_flow_by(1995),
            "2000": extra.net_flow_by(2000),
            "2005": extra.net_flow_by(2005),
            "2010": extra.net_flow_by(2010),
            "2015": extra.net_flow_by(2015),
            "2017": extra.net_flow_by(2017)
          },
          info: extra.parse_flows(self)
      }
    }
  end

  def parse_flows(extra)
    parsed = {}
    flows = self.emigrations.select {|flow| flow.destination_id == extra.id}
    flows.each do |flow|
      parsed[flow.year] = flow.quantity
    end
    parsed
  end


end
