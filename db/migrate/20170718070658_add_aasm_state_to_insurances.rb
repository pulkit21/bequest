class AddAasmStateToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :aasm_state, :string
  end
end
