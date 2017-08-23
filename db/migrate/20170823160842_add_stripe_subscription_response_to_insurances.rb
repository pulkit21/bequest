class AddStripeSubscriptionResponseToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :stripe_subscription_response, :jsonb
  end
end
