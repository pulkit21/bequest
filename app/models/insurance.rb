class Insurance < ApplicationRecord
  include AASM

  belongs_to :user

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

  #######################################################################################################################
  #######################################################################################################################
  # Subscription will have 3 step
  # 1- Define a plan.
  # 2- Create a customer.
  # 3- Subscribe a customer to a plan.

  # STEP 1: Create Plan in Stripe Dashboard
  def create_stripe_plan
    plan = Stripe::Plan.create(
      name: "#{self.payment_frequency.titleize} payment $#{self.coverage_amount} for terms #{self.coverage_term_age} Plan",
      id: self.id,
      interval: set_stripe_interval[:interval],
      interval_count: set_stripe_interval[:interval_count],
      currency: "usd",
      amount: (self.coverage_payment * 100).to_i,
      metadata: {
        payment_frequency: self.payment_frequency,
        coverage_age: self.coverage_age,
        coverage_amount: self.coverage_amount
      }
    )
    self.update_columns(stripe_plan_id: plan.id, stripe_plan_response: plan)
  end

  # STEP 2: Create customer in Stripe
  def create_stripe_customer
    customer = Stripe::Customer.create(email: self.user.email, metadata: {age: self.current_age})
    self.update_columns(stripe_customer: customer.id)
  end

  # STEP 3: Subscribe a customer to a plan
  def subscribe_customer_to_a_plan
    subscribe = Stripe::Subscription.create(
      customer: self.stripe_customer,
      plan: self.stripe_plan_id,
    )
    self.update_columns(stripe_subscription_response: subscribe)
  end

  def initialize_net_http_ssl(uri)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = uri.scheme == 'https'

    if defined?(Rails) && Rails.env.test?
      in_rails_test_env = true
    else
      in_rails_test_env = false
    end

    if http.use_ssl? && !in_rails_test_env
      # Explicitly verifies that the certificate matches the domain.
      # Requires that we use www when calling the production DocuSign API
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.verify_depth = 5
    else
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    http
  end

  # TODO make Docu service
  def get_combined_document(options={})
    headers = {
      "X-DocuSign-Authentication"=>
        "{\"Username\":\"19a86757-dd75-469a-a4cc-c21cf2df5b29\",\"Password\":\"B3qu3stLife2017!\",\"IntegratorKey\":\"c78e294d-b27f-42ba-bf3e-7f28e7e84da4\"
      }",
      "Accept"=>"json",
      "Content-Type"=>"application/json"
    }
    uri = URI.parse("https://demo.docusign.net/restapi/v2/accounts/#{Rails.application.secrets.docosign_account_id}/envelopes/#{options[:envelope_id]}/documents/combined")

    http = initialize_net_http_ssl(uri)
    request = Net::HTTP::Get.new(uri.request_uri, headers)
    response = http.request(request)
    obj = ::AmazonS3Service.new.save_pdf(options[:envelope_id], response)
    self.update_columns(policy: obj.key)
    # Insurance.first.get_combined_document(envelope_id: "45bfa861-509b-4088-8e89-9de255ee6088", document_id: 1)
  end


  # Sign the document using
  # TODO- Add the user specifc data
  def sign_policy
    client = DocusignRest::Client.new
    file_io = open(Rails.application.secrets.document_url)
    document_envelope_response = client.create_envelope_from_document(
      email: {
        subject: "Coverage Policy",
        body: "this is the email body and it's large!"
      },
      signers: [
        {
          embedded: true,
          name: self.user.full_name,
          email: self.user.email,
          role_name: 'Issuer',
          sign_here_tabs: [
            {
              anchor_string: "SIGNATURE",
              anchor_x_offset: '210',
              anchor_y_offset: '-15'
            }
          ],
          text_tabs: [
            {
              label: "NAME OF INSURED",
              name: "NAME OF INSURED",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '155',
              y_position: '132',
              value: self.user.full_name
            },
            {
              label: "ADDRESS OF INSURED",
              name: "ADDRESS OF INSURED",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '165',
              y_position: '156',
              value: self.user.address
            },
            {
              label: "CONTRACT NUMBER",
              name: "CONTRACT NUMBER",
              locked: true,
              font_color: "Gold",
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              x_position: '160',
              y_position: '181',
              page_number: 2,
              value: ActiveSupport::NumberHelper.number_to_phone(self.user.phone_number, country_code: 1)
            },
            {
              label: "COVERAGE AMOUNT",
              name: "COVERAGE AMOUNT",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '160',
              y_position: '205',
              value: "$#{add_commas_to_numbers(self.coverage_amount)}"
            },
            {
              label: "PREMIUM PAYMENT",
              name: "PREMIUM PAYMENT",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '160',
              y_position: '229',
              value: "$#{self.coverage_payment} #{self.payment_frequency.upcase}"
            },
            {
              label: "INSURED ISSUE AGE",
              name: "INSURED ISSUE AGE",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '155',
              y_position: '253',
              value: "#{self.current_age}"
            },
            {
              label: "GENDER",
              name: "GENDER",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '110',
              y_position: '278',
              value: "#{self.gender.capitalize}"
            },
            {
              label: "PAYABLE TO",
              name: "PAYABLE TO",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '125',
              y_position: '303',
              value: "AGE 65"
            },
            {
              label: "EFFECTIVE DATE",
              name: "EFFECTIVE DATE",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '140',
              y_position: '327',
              value: "#{self.effective_date}"
            },
            {
              label: "MATURITY DATE",
              name: "MATURITY DATE",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '140',
              y_position: '351',
              value: "#{self.maturity_date}"
            },
            {
              label: "DATE",
              name: "DATE",
              locked: true,
              page_number: 2,
              font: "Calibri",
              font_size: "Size10",
              bold: true,
              font_color: "Gold",
              x_position: '107',
              y_position: '470',
              value: "#{self.current_date}"
            }
          ]
        },
      ],
      files: [
        {io: file_io, name: 'policy.pdf'},
      ],
      status: 'sent'
    )
    self.update_columns(docusign_response: document_envelope_response)
    url = client.get_recipient_view(
        envelope_id: self.docusign_response['envelopeId'],
        name: self.user.full_name,
        email: self.user.email,
        return_url: "#{ActionMailer::Base.default_url_options[:host]}/insurance/confirm?insurance=#{self.id}&envelope_id=#{self.docusign_response['envelopeId']}"
      )['url']
    url
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

  #######
  private
  #######



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
        create_stripe_plan
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
      PolicyMailer.send_signature_link(self).deliver_now
      self.subscribe_customer_to_a_plan
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
    self.create_stripe_customer
  end

end
