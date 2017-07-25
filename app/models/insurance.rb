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
  validate :check_coverage_stage, on: :update, if: :question?
  validates_presence_of :terms_and_services, if: :coverage?
  validate :check_payment_stage, on: :update, if: :coverage?

  enum gender: ["male", "female"]
  enum payment_frequency: {"annual" => 0, "semi-annual" => 10 , "quarterly" => 20, "monthly" => 30}
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

  #######
  private
  #######

  def check_coverage_stage
    if coverage_amount && self.question?
      self.update_columns(aasm_state: "coverage")
      puts "#{self.inspect}"
    else
      errors.add(:coverage_amount, "Invalide amount.")
    end
  end

  def check_payment_stage
    if payment_frequency && terms_and_services && self.coverage?
      self.update_columns(aasm_state: "payment")
    else
      errors.add(:payment, "Please accept payment frequency.")
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
    self.update_columns(aasm_state: "question")
  end

end
