require 'csv'

csv_text_countries = File.read(Rails.root.join('lib', 'seeds', 'countries.csv'))
csv_text_migrations = File.read(Rails.root.join('lib', 'seeds', 'migrations.csv'))

csv_countries = CSV.parse(csv_text_countries, :headers => true)
csv_migrations = CSV.parse(csv_text_migrations, :headers => true)

csv_countries.each do |row|
  c = Country.new
  c.name = row['Country']

  if row['High-income Countries'] == "Y"
    c.high_income = true
  elsif row['High-income Countries'] == "N"
    c.high_income = false
  else
    c.high_income = nil
  end

  if row['Upper-middle-income Countries'] == "Y"
    c.upper_middle_income = true
  elsif row['Upper-middle-income Countries'] == "N"
    c.upper_middle_income = false
  else
    c.upper_middle_income = nil
  end

  if row['Middle-income Countries'] == "Y"
    c.middle_income = true
  elsif row['Middle-income Countries'] == "N"
    c.middle_income = false
  else
    c.middle_income = nil
  end

  if row['Lower-middle-income Countries'] == "Y"
    c.lower_middle_income = true
  elsif row['Lower-middle-income Countries'] == "N"
    c.lower_middle_income = false
  else
    c.lower_middle_income = nil
  end

  if row['Low-income Countries'] == "Y"
    c.low_income = true
  elsif row['Low-income Countries'] == "N"
    c.low_income = false
  else
    c.low_income = nil
  end

  if row['Region'] != "?"
    c.region = row['Region']
  else
    c.region = 'N/A'
  end

  c.save

  # puts "#{c.name} saved"
end

puts "COUNTRIES FINISHED"

csv_migrations.each do |row|
  year = row['Year']
  destination = Country.find_by(name: row['Country'])

  row.each do |col|

    if col[0] == 'Year' || col[0] == 'Country'
      # do nothing
    elsif col[1] == 'N/A'
      # do nothing
    else
      origin = Country.find_by(name: col[0])
      quantity = col[1].to_s.gsub(/,/, '').to_i

      newFlow = Flow.new
      newFlow.origin_id = origin.id
      newFlow.destination_id = destination.id
      newFlow.quantity = quantity
      newFlow.year = year
      newFlow.save
      # puts "From: " + origin.name
      # puts "To: " + destination.name
    end
  end
end

puts "FLOWS FINISHED"
