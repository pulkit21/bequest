class AddStripeCustomerToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :stripe_customer, :string
  end
end
