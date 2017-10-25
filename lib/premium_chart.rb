require 'json'

module PremiumChart
  extend self

  def term_male_data(amount, age)
    keys =  [50000, 100000, 150000, 200000, 250000, 300000, 350000, 400000 450000, 500000, 550000, 600000, 650000, 700000, 750000, 800000, 850000, 900000, 950000, 1000000, 1050000, 1100000, 1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000, 1900000, 1950000, 2000000]
    file = File.read('app/views/insurances/chart_data.json')
    map = JSON.parse(file)
    amount_value = keys.index(amount)
    percentage = map["term_male_data"][age.to_s][amount_value]
  end

  def term_female_data(amount, age)
    keys =  [50000, 100000, 150000, 200000, 250000, 300000, 350000, 400000 450000, 500000, 550000, 600000, 650000, 700000, 750000, 800000, 850000, 900000, 950000, 1000000, 1050000, 1100000, 1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000, 1900000, 1950000, 2000000]
    file = File.read('app/views/insurances/chart_data.json')
    map = JSON.parse(file)
    amount_value = keys.index(amount)
    percentage = map["term_female_data"][age.to_s][amount_value]
  end


  def accidental_male_data(amount, age)
    keys =  [50000, 100000, 150000, 200000, 250000, 300000, 350000, 400000 450000, 500000, 550000, 600000, 650000, 700000, 750000, 800000, 850000, 900000, 950000, 1000000, 1050000, 1100000, 1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000, 1900000, 1950000, 2000000]
    file = File.read('app/views/insurances/chart_data.json')
    map = JSON.parse(file)
    amount_value = keys.index(amount)
    percentage = map[age.to_s][amount_value]
  end



  def accidental_female_data(amount, age)
    keys =  [50000, 100000, 150000, 200000, 250000, 300000, 350000, 400000 450000, 500000, 550000, 600000, 650000, 700000, 750000, 800000, 850000, 900000, 950000, 1000000, 1050000, 1100000, 1150000, 1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000, 1600000, 1650000, 1700000, 1750000, 1800000, 1850000, 1900000, 1950000, 2000000]
    file = File.read('app/views/insurances/chart_data.json')
    map = JSON.parse(file)
    amount_value = keys.index(amount)
    percentage = map[age.to_s][amount_value]
  end
end
