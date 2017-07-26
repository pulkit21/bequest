class AddFieldsToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :coverage_age, :integer
    add_column :insurances, :coverage_payment, :integer
  end
end
