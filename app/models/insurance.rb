class Insurance < ApplicationRecord
  include AASM
  self.inheritance_column = 'product'

  belongs_to :user
  has_many :beneficiaries

  accepts_nested_attributes_for :beneficiaries, reject_if: :all_blank, allow_destroy: true, limit: 5

  validates_presence_of :product, if: :idle?
  after_create :change_state_to_product, if: :idle?


  validate :check_payment_stage, on: :update, if: :beneficiary?

  validate :check_beneficiary_count, if: :frequency?
  validate :beneficiary_allocation_percentage, if: :frequency?
  validate :check_beneficiary, on: :update, if: :frequency?


  validate :check_premium_frequency, if: :coverage?

  validate :check_coverage_stage, on: :update, if: :license?

  validates_presence_of :driving_license, if: :phone?
  validate :check_license, if: :phone?

  validates :phone_number, phone: true, if: :street?
  validate :check_phone_number, if: :street?

  validates_presence_of :address, if: :weight?
  validate :check_address, if: :weight?

  validate :body_mass_index, if: :height?
  validates_presence_of :weight, if: :height?
  validate :check_weight, if: :height?

  validates_presence_of :height, if: :birthday?
  validate :check_height, if: :birthday?

  validate :check_current_age, if: :gender?
  validates_presence_of :birthday, if: :gender?
  validate :check_birthday, if: :gender?

  validates_presence_of :gender, if: :alcohol?
  validate :check_gender, if: :alcohol?

  validates_inclusion_of :alcohol, in: [true, false], if: :driving?
  validate :check_alcohol_usage, on: :update, if: :driving?

  validates_inclusion_of :driving, in: [true, false], if: :occupation?
  validate :check_driving_charge, on: :update, if: :occupation?

  validates_inclusion_of :occupation, in: [true, false], if: :family_history?
  validate :check_occupation, on: :update, if: :family_history?

  validates_inclusion_of :family_history, in: [true, false], if: :cholesterol?
  validate :check_family_history, on: :update, if: :cholesterol?

  validates_inclusion_of :cholesterol, in: [true, false], if: :blood?
  validate :check_cholesterol_condition, on: :update, if: :blood?

  validates_inclusion_of :blood, in: [true, false], if: :history?
  validate :check_blood_condition, on: :update, if: :history?

  validates_inclusion_of :health_condition, in: [true, false], if: :tobacco?
  validate :check_health_condition, on: :update, if: :tobacco?

  validates_inclusion_of :tobacco_product, in: [true, false], if: :product?
  validate :check_tobacco_usage, on: :update, if: :product?

  enum gender: ["male", "female"]
  enum payment_frequency: {"annual" => 0, "semi" => 10 , "quarterly" => 20, "monthly" => 30}
  # --------------------------------------------------------------------------
  # State Machine
  # --------------------------------------------------------------------------
  aasm do
    state :idle, initial: true
    state :product
    state :tobacco
    state :history
    state :blood
    state :cholesterol
    state :family_history
    state :occupation
    state :driving
    state :alcohol
    state :gender
    state :birthday
    state :height
    state :weight
    state :street
    state :phone
    state :license
    state :frequency
    state :beneficiary
    state :question
    state :coverage
    state :payment
    state :signature
    state :confirmation

    after_all_transitions :log_status_change

    event :product_type do
      transitions from: :idle, to: :product
    end

    event :tobacco_used do
      transitions from: :product, to: :tobacco
    end

    event :any_history do
      transitions from: :tobacco, to: :history
    end

    event :blood_type do
      transitions from: :history, to: :blood
    end

    event :have_cholesterol do
      transitions from: :blood, to: :cholesterol
    end

    event :any_family_history do
      transitions from: :cholesterol, to: :family_history
    end

    event :any_occupation do
      transitions from: :family_history, to: :occupation
    end

    event :drive do
      transitions from: :occupation, to: :driving
    end

    event :drinking do
      transitions from: :driving, to: :alcohol
    end

    event :gender_type do
      transitions from: :alcohol, to: :gender
    end

    event :birth do
      transitions from: :gender, to: :birthday
    end

    event :user_height do
      transitions from: :birthday, to: :height
    end

    event :user_weight do
      transitions from: :height, to: :weight
    end

    event :street_address_address do
      transitions from: :weight, to: :street
    end

    event :contact do
      transitions from: :street, to: :phone
    end

    event :license_number do
      transitions from: :phone, to: :license
    end

    event :amount_coverage do
      transitions from: :license, to: :coverage
    end


    event :frequency_type do
      transitions from: :coverage, to: :frequency
    end

    event :add_beneficiary do
      transitions from: :frequency, to: :beneficiary
    end

    # event :ques do
    #   transitions from: :idle, to: :question
    # end

    # event :cover do
    #   transitions from: :question, to: :coverage
    # end

    # event :pay do
    #   transitions from: :coverage, to: :payment
    # end

    # event :sign do
    #   transitions from: :payment , to: :signature
    # end

    # event :confirm do
    #   transitions from: :signature, to: :confirmation
    # end
  end

  def self.products
    [
      'Term',
      'Accidental'
    ]
  end

  def log_status_change
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
  end

  def full_address
    "#{address}, #{self.user.city}, #{self.user.state}"
  end

  # Current Age
  def current_age
    Date.today.year - self.birthday.year
  end

  # Coverage term age
  def coverage_term_age
    65 - current_age
  end

  def maturity_date
    DateTime.now.next_year(coverage_term_age).strftime("%^b %d, %Y")
  end

  def effective_date
    DateTime.now.strftime("%^b %d, %Y")
  end

  def current_date
    DateTime.now.strftime("%m/%d/%Y")
  end

  def add_commas_to_numbers(num_string)
    num_string.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end

  # Submit the credit/debit card details for the customer in stripe
  def submit_card_details_in_stripe(params)
    status = {
      error_status: true,
      message: nil
    }
    customer = Stripe::Customer.retrieve(self.stripe_customer)
    begin
      customer.sources.create(source: params[:stripe_token])
      status[:error_status] = false
      status
    rescue Stripe::CardError => e
      status[:message] = e
      return status
    rescue => e
      status[:message] = e
      return status
    end
  end

  def docs_status
    if self.aasm_state == "confirmation"
      true
    else
      false
    end
  end

  #########################################################################################################################
  #########################################################################################################################

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

  #######
  private
  #######

  def change_state_to_product
    self.update_columns(aasm_state: "product")
  end

  def check_tobacco_usage
    if self.product?
      self.update_columns(aasm_state: "tobacco")
    end
  end

  def check_health_condition
    if self.tobacco?
      self.update_columns(aasm_state: "history")
    end
  end

  def check_blood_condition
    if self.history?
      self.update_columns(aasm_state: "blood")
    end
  end

  def check_cholesterol_condition
    if self.blood?
      self.update_columns(aasm_state: "cholesterol")
    end
  end

  def check_family_history
    if self.cholesterol?
      self.update_columns(aasm_state: "family_history")
    end
  end

  def check_occupation
    if self.family_history?
      self.update_columns(aasm_state: "occupation")
    end
  end

  def check_driving_charge
    if self.occupation?
      self.update_columns(aasm_state: "driving")
    end
  end

  def check_alcohol_usage
    if self.driving?
      self.update_columns(aasm_state: "alcohol")
    end
  end

  def check_gender
    if self.alcohol?
      self.update_columns(aasm_state: "gender")
    end
  end

  def check_birthday
    if self.gender?
      self.update_columns(aasm_state: "birthday", coverage_age: self.coverage_term_age)
      ::StripeService.new.create_stripe_customer(self)
    end
  end

  def check_current_age
    if birthday.present?
      current_date = Time.now.utc.to_date
      current_age = current_date.year - birthday.year - ((current_date.month > birthday.month || (current_date.month == birthday.month && current_date.day >= birthday.day)) ? 0 : 1)
      if current_age < 18 || current_age >= 65
        errors.add(:age_coverage, "Sorry but we do not offer coverage to individuals of your age.")
      end
    end
  end

  def check_height
    if self.birthday?
      self.update_columns(aasm_state: "height")
    end
  end

  def check_weight
    if self.height?
      self.update_columns(aasm_state: "weight")
    end
  end

  def body_mass_index
    if height.present? && weight.present? && height_inches.present?
      height_in_inches = height_inches > 9 ? height.to_f * 12 + ( height_inches* 12).to_f / 100 : height.to_f * 12 + ( height_inches * 12).to_f / 10
      body_mass = 703 * (height_in_inches.to_f / (weight * weight))
      if body_mass > 30
        errors.add(:weight_coverage, "Sorry but we do not offer coverage to individuals of your height and weight.")
      end
    end
  end

  def check_address
    if self.weight?
      self.update_columns(aasm_state: "street")
    end
  end

  def check_phone_number
    if self.street?
      self.update_columns(aasm_state: "phone")
    end
  end

  def check_license
    if self.phone?
      self.update_columns(aasm_state: "license")
    end
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
    if coverage_amount.present? && self.license? && coverage_payment.present?
      if coverage_payment == percentage_calculator(coverage_amount, self.coverage_term_age)
        self.update_columns(aasm_state: "coverage")
      else
        errors.add(:coverage_payment, "Invalide coverage percentage.")
      end
    else
      errors.add(:coverage_amount, "Invalide amount.")
    end
  end

  def check_premium_frequency
    if self.coverage?
      self.update_columns(aasm_state: "frequency")
      ::StripeService.new.create_stripe_plan(self)
    end
  end

  def beneficiary_allocation_percentage
    unless self.beneficiaries.map(&:allocated_percentage).sum == 100
      errors.add(:beneficiaries, "Allocation percentage should be hundred.")
    end
  end

  def check_beneficiary_count
    unless self.beneficiaries.present?
      errors.add(:beneficiaries, "Please add atleast one beneficiary.")
    end
  end

  def check_beneficiary
    if self.frequency?
      self.update_columns(aasm_state: "beneficiary")
    end
  end

  def check_payment_stage
    if self.beneficiary?
      self.update_columns(aasm_state: "payment")
      PolicyMailer.send_signature_link(self).deliver_now
      ::StripeService.new.subscribe_customer_to_a_plan(self)
    end
  end

end
