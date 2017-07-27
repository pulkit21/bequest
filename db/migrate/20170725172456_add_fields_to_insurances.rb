class AddFieldsToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :coverage_age, :integer
    add_column :insurances, :coverage_payment, :decimal, precision: 15, scale: 2
  end
end
