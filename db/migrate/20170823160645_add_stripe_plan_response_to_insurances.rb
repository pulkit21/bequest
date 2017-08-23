class AddStripePlanResponseToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :stripe_plan_response, :jsonb
  end
end
