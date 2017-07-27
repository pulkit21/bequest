class AddStripePlanIdToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :stripe_plan_id, :string
  end
end
