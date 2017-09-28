class AddHeightInInchesToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :height_inches, :integer
  end
end
