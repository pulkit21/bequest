class Insurance < ApplicationRecord
  include AASM

  belongs_to :user

  validates_presence_of :tobacco_product, :health_condition, :gender, :birthday, :terms_and_services, :payment_frequency
  validates :height, :weight, :coverage_amount, presence: true, numericality: true

  # --------------------------------------------------------------------------
  # State Machine
  # --------------------------------------------------------------------------
  aasm do
    state :question, initial: true
    state :coverage
    state :payment
    state :signature
    state :confirmation

    event :cover do
      transitions :from => :question, :to => :coverage
    end

    event :pay do
      transitions :from => [:question, :coverage], :to => :payment
    end

    event :sign do
      transitions :from => [:question, :coverage, :payment], :to => :signature
    end

    event :confirm do
      transitions :from => [:question, :coverage, :payment, :signature], :to => :confirmation
    end
  end
end
