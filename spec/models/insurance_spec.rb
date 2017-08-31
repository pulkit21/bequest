require 'rails_helper'

RSpec.describe Insurance, type: :model do
  describe 'data validation' do
    before do
      @user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "bequest123",
        # confirm_password: "bequest123",
        zipcode: "00501"
      )
    end

    it "should create insurance with valid attributes" do
      insurance = build(:insurance, tobacco_product: false,
          health_condition: true,
          gender: 'male',
          birthday: Date.parse("1989-05-19"),
          height: 169,
          weight: 150,
          address: Faker::Address.street_address,
          state: "NY",
          city: Faker::Address.city,
          phone_number: "2025550106",
          user: @user
        )
      expect(insurance.aasm_state).to eq("idle")
      insurance.save!
      expect(insurance.persisted?).to be_truthy
      expect(insurance.aasm_state).to eq("question")
      insurance.update(coverage_amount: 1200000, coverage_payment: 139, payment_frequency: 'annual')
      expect(insurance.persisted?).to be_truthy
      expect(insurance.aasm_state).to eq("coverage")
      insurance.update(terms_and_services: true)
      expect(insurance.persisted?).to be_truthy
      expect(insurance.aasm_state).to eq("payment")

    end

    it "should not create insurance without tobacco product attribute" do
      insurance = build(:insurance, tobacco_product: nil,
          health_condition: true,
          gender: 'male',
          birthday: Date.parse("1989-05-19"),
          height: 169,
          weight: 150,
          address: Faker::Address.street_address,
          state: "NY",
          city: Faker::Address.city,
          phone_number: "2025550106",
          user: @user)

      expect(insurance.valid?).to be_falsey
    end

    it "should not create insurance without health condition attribute" do
      insurance = build(:insurance, tobacco_product: false, health_condition: '', gender: 'male', birthday: Date.parse("1989-05-19"), height: 169, weight: 150)
      expect(insurance.valid?).to be_falsey
    end

    it "should not create insurance without gender attribute" do
      insurance = build(:insurance, tobacco_product: false, health_condition: true, gender: '', birthday: Date.parse("1989-05-19"), height: 169, weight: 150)
      expect(insurance.valid?).to be_falsey
    end

    it "should not update insurance without coverage amount attribute and should not change state to coverage" do
      insurance = build(:insurance,
        tobacco_product: false,
        health_condition: true,
        gender: 'male',
        birthday: Date.parse("1989-05-19"),
        height: 169,
        weight: 150,
        address: Faker::Address.street_address,
        state: "NY",
        city: Faker::Address.city,
        phone_number: "2025550106",
        user: @user
      )
      insurance.save!
      expect(insurance.persisted?).to be_truthy
      expect(insurance.aasm_state).to eq("question")
      insurance.update(coverage_amount: '')
      expect(insurance.valid?).to be_falsey
      expect(insurance.aasm_state).to eq("question")
    end

    it "should not update insurance without terms & services, payment frequency attributes and should not change state to payment" do
      insurance = build(:insurance,
          tobacco_product: false,
          health_condition: true,
          gender: 'male',
          birthday: Date.parse("1989-05-19"),
          height: 169,
          weight: 150,
          address: Faker::Address.street_address,
          state: "NY",
          city: Faker::Address.city,
          phone_number: "2025550106",
          user: @user)
      insurance.save!
      expect(insurance.persisted?).to be_truthy
      expect(insurance.aasm_state).to eq("question")
      insurance.update(coverage_amount: 1200000, coverage_payment: 139, payment_frequency: "annual")
      expect(insurance.persisted?).to be_truthy
      expect(insurance.aasm_state).to eq("coverage")
      insurance.update(terms_and_services: false)
      expect(insurance.valid?).to be_falsey
      expect(insurance.aasm_state).to eq("coverage")
      expect(insurance.errors.full_messages.first).to eq("Terms and services can't be blank")
      insurance.update(terms_and_services: true)
    end
  end

  describe "age validation error" do
    # before do
    #   @insurance = Insurance.new(tobacco_product: false, health_condition: true, gender: 'male', birthday: Date.parse("2011-05-19"), height: 169, weight: 150)
    # end
    before do
      @user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "bequest123",
        zipcode: "00501"
      )
    end
    it "should not create insurance without date attribute" do
      insurance = build(:insurance, tobacco_product: false, health_condition: true, gender: 'male', birthday: '', height: 169, weight: 150, user: @user)
      expect(insurance.valid?).to be_falsey
    end

    it "it should not be valid if age is less than 18 years" do
      @insurance = Insurance.new(
        tobacco_product: false,
        health_condition: true,
        gender: 'male',
        birthday: Date.parse("2011-05-19"),
        height: 169,
        weight: 150,
        address: Faker::Address.street_address,
        state: "NY",
        city: Faker::Address.city,
        phone_number: "2025550106",
        user: @user
      )
      @insurance.valid?
      expect(@insurance.errors.full_messages.first).to eq("Age coverage Sorry but we do not offer coverage to individuals of your age.")
    end

    it "it should not be valid if age is equal to 65 years" do
      @insurance = Insurance.new(
        tobacco_product: false,
        health_condition: true,
        gender: 'male',
        birthday: Date.parse("1952-05-19"),
        height: 169,
        weight: 150,
        address: Faker::Address.street_address,
        state: "NY",
        city: Faker::Address.city,
        phone_number: "2025550106",
        user: @user
      )
      @insurance.valid?
      # @insurance.errors.full_messages.should include("Age coverage Sorry but we do not offer coverage to individuals of your age.")
      expect(@insurance.errors.full_messages.first).to eq("Age coverage Sorry but we do not offer coverage to individuals of your age.")
    end

    it "it should not be valid if age is equal to 65 years" do
      @insurance = Insurance.new(
        tobacco_product: false,
        health_condition: true,
        gender: 'male',
        birthday: Date.parse("1950-05-19"),
        height: 169,
        weight: 150,
        address: Faker::Address.street_address,
        state: "NY",
        city: Faker::Address.city,
        phone_number: "2025550106",
        user: @user
      )
      @insurance.valid?
      expect(@insurance.errors.full_messages.first).to eq("Age coverage Sorry but we do not offer coverage to individuals of your age.")
    end
  end

  describe "body weight and height validation error" do
    before do
      @user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "bequest123",
        zipcode: "00501"
      )
    end
    it "should not create insurance without height attribute" do
      insurance = build(:insurance, tobacco_product: false, health_condition: true, gender: 'male', birthday: Date.parse("1989-05-19"), height: '', weight: 150)
      expect(insurance.valid?).to be_falsey
    end

    it "should not create insurance without weight attribute" do
      insurance = build(:insurance, tobacco_product: false, health_condition: true, gender: 'male', birthday: Date.parse("1989-05-19"), height: 169, weight: '')
      expect(insurance.valid?).to be_falsey
    end
    it "it should not be valid if weight and height are have greated body mass than 50" do
      @insurance = Insurance.new(
        tobacco_product: false,
        health_condition: true,
        gender: 'male',
        birthday: Date.parse("1989-05-19"),
        height: 169,
        weight: 60,
        address: Faker::Address.street_address,
        state: "NY",
        city: Faker::Address.city,
        phone_number: "2025550106",
        user: @user
      )
      @insurance.valid?
      expect(@insurance.errors.full_messages.first).to eq("Weight coverage Sorry but we do not offer coverage to individuals of your height and weight.")
    end
  end

end
