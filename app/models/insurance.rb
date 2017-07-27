class Insurance < ApplicationRecord
  include AASM

  validates_inclusion_of :tobacco_product, :health_condition, in: [true, false], if: :idle?
  validates_presence_of :gender, :birthday, if: :idle?
  validates :height, :weight, presence: true, numericality: true, if: :idle?
  after_create :change_state_to_question, if: :idle?
  # validates :coverage_amount, presence: true, numericality: true, if: :question?
  # validates_presence_of :tobacco_product, :health_condition, ¡:gender, :birthday, :terms_and_services, :payment_frequency
  # validates :height, :weight, :coverage_amount, presence: true, numericality: true
  validate :body_mass_index, on: :create
  validate :check_current_age, on: :create
  validates_presence_of :terms_and_services, if: :coverage?
  validate :check_payment_stage, on: :update, if: :coverage?
  validate :check_coverage_stage, on: :update, if: :question?

  enum gender: ["male", "female"]
  enum payment_frequency: {"annual" => 0, "semi" => 10 , "quarterly" => 20, "monthly" => 30}
  # --------------------------------------------------------------------------
  # State Machine
  # --------------------------------------------------------------------------
  aasm do
    state :idle, initial: true
    state :question
    state :coverage
    state :payment
    state :signature
    state :confirmation

    after_all_transitions :log_status_change

    event :ques do
      transitions from: :idle, to: :question
    end

    event :cover do
      transitions from: :question, to: :coverage
    end

    event :pay do
      before do
        instance_eval do
          validates_presence_of :terms_and_services, :payment_frequency
        end
      end
      transitions from: :coverage, to: :payment
    end

    event :sign do
      transitions from: :payment , to: :signature
    end

    event :confirm do
      transitions from: :signature, to: :confirmation
    end
  end

  def log_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end

  # Current Age
  def current_age
    Date.today.year - self.birthday.year
  end

  # Coverage term age
  def coverage_term_age
    65 - current_age
  end

  # def self.chat_calculation(current_age, current_amount)
  #   min_age = 18
  #   min_amount = 100000
  #   current_age_group =  current_age - min_age
  #   premium_amount = current_amount / min_amount
  #   premium_amount = premium_amount - 1
  #   current_age_group = current_age_group if current_age_group >= 0 && current_age_group <= 64
  #   exact_percentage = (10 + current_age_group) + (10 * premium_amount)
  # end

  # #######
  # private
  # #######

  # Create customer in Stripe
  def create_stripe_customer
    customer = Stripe::Customer.create(email: "bequest@mailinator.com", metadata: {age: self.current_age})
    self.update_columns(stripe_customer: customer.id)
  end

  def set_stripe_interval
    stripe_intervals = {}
    if self.annual?
      stripe_intervals = {interval: "year", interval_count: 1}
    elsif self.semi?
      stripe_intervals = {interval: "month", interval_count: 6}
    elsif self.quarterly?
      stripe_intervals = {interval: "month", interval_count: 3}
    elsif self.monthly?
      stripe_intervals = {interval: "month", interval_count: 1}
    end
    stripe_intervals
  end

  def create_stripe_plan
    plan = Stripe::Plan.create(
      name: "#{self.payment_frequency.titleize} payment $#{self.coverage_amount} for terms #{self.coverage_term_age} Plan",
      id: self.id,
      interval: set_stripe_interval[:interval],
      interval_count: set_stripe_interval[:interval_count],
      currency: "usd",
      amount: 0,
      metadata: {
        payment_frequency: self.payment_frequency,
        coverage_age: self.coverage_age,
        coverage_amount: self.coverage_amount
      }
    )
    plan
  end

  def percentage_calculator(amount, age)
    premium_amount = PremiumChart.data(amount, age)
    if self.semi?
      coverage_payment = ((10.to_f / premium_amount) * 100) + premium_amount
    elsif self.quarterly?
      coverage_payment = ((20.to_f / premium_amount) * 100) + premium_amount
    elsif self.monthly?
      coverage_payment = ((30.to_f / premium_amount) * 100) + premium_amount
    else
      coverage_payment =  premium_amount
    end
    coverage_payment = coverage_payment.round(2)
  end

  def check_coverage_stage
    if coverage_amount && self.question? && coverage_payment && payment_frequency
      if coverage_payment == percentage_calculator(coverage_amount, self.coverage_term_age)
        self.update_columns(aasm_state: "coverage")
        puts "#{self.inspect}"
      else
        errors.add(:coverage_payment, "Invalide coverage percentage.")
      end
    else
      errors.add(:coverage_amount, "Invalide amount.")
    end
  end

  def check_payment_stage
    if terms_and_services && self.coverage?
      self.update_columns(aasm_state: "payment")
    else
      errors.add(:terms_and_services, "Please accept terms and services.")
    end
  end

  def body_mass_index
    if height && weight
      body_mass = 703 * (height.to_f / (weight * weight))
      if body_mass > 30
        errors.add(:weight_coverage, "Sorry but we do not offer coverage to individuals of your height and weight.")
      end
    end
  end

  def check_current_age
    if birthday
      current_date = Time.now.utc.to_date
      current_age = current_date.year - birthday.year - ((current_date.month > birthday.month || (current_date.month == birthday.month && current_date.day >= birthday.day)) ? 0 : 1)
      if current_age < 18 || current_age >= 65
        errors.add(:age_coverage, "Sorry but we do not offer coverage to individuals of your age.")
      end
    end
  end

  def change_state_to_question
    self.update_columns(aasm_state: "question", coverage_age: self.coverage_term_age)
  end

end
