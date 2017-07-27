class AddStripeResponseToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :stripe_response, :jsonb
  end
end
