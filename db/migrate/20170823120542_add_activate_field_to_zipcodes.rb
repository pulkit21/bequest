class AddActivateFieldToZipcodes < ActiveRecord::Migration[5.1]
  def change
    add_column :zipcodes, :activate, :boolean, default: true
  end
end
