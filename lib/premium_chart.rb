require 'json'

module PremiumChart
  extend self

  def data(amount, age)
    keys =  [100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000, 1000000, 1100000, 1200000, 1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000]
    file = File.read('app/views/insurances/chart_data.json')
    map = JSON.parse(file)
    amount_value = keys.index(amount)
    percentage = map[age.to_s][amount_value]
  end
end
