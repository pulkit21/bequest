class AddAddressFieldsToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :address, :string
    add_column :insurances, :city, :string
    add_column :insurances, :state, :string
    add_column :insurances, :zipcode, :string
    add_column :insurances, :phone_number, :string
  end
end
