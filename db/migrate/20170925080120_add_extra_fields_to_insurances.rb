class AddExtraFieldsToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :product, :string, index: true
    add_column :insurances, :alcohol, :boolean
    add_column :insurances, :blood, :boolean
    add_column :insurances, :cholesterol, :boolean
    add_column :insurances, :driving, :boolean
    add_column :insurances, :family_history, :boolean
    add_column :insurances, :occupation, :boolean
  end
end
