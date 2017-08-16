class AddDrivingLicenseToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :driving_license, :string
  end
end
