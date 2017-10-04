class StripeService

  def initialize

  end

  #######################################################################################################################
  #######################################################################################################################
  # Subscription will have 3 step
  # 1- Define a plan.
  # 2- Create a customer.
  # 3- Subscribe a customer to a plan.

  # STEP 1: Create Plan in Stripe Dashboard
  def create_stripe_plan(insurance)
    plan = Stripe::Plan.create(
      name: "#{insurance.payment_frequency.titleize} payment $#{insurance.coverage_amount} for terms #{insurance.coverage_term_age} Plan",
      id: insurance.id,
      interval: insurance.set_stripe_interval[:interval],
      interval_count: insurance.set_stripe_interval[:interval_count],
      currency: "usd",
      amount: (insurance.coverage_payment * 100).to_i,
      metadata: {
        payment_frequency: insurance.payment_frequency,
        coverage_age: insurance.coverage_age,
        coverage_amount: insurance.coverage_amount
      }
    )
    insurance.update_columns(stripe_plan_id: plan.id, stripe_plan_response: plan)
  end

  # STEP 2: Create customer in Stripe
  def create_stripe_customer(insurance)
    customer = Stripe::Customer.create(email: insurance.user.email, metadata: {age: insurance.current_age})
    insurance.update_columns(stripe_customer: customer.id)
  end

  # STEP 3: Subscribe a customer to a plan
  def subscribe_customer_to_a_plan(insurance)
    subscribe = Stripe::Subscription.create(
      customer: insurance.stripe_customer,
      plan: insurance.stripe_plan_id,
    )
    insurance.update_columns(stripe_subscription_response: subscribe)
  end

end
