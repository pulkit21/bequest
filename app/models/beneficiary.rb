class Beneficiary < ApplicationRecord
  belongs_to :insurance
  validates_presence_of :first_name, :last_name, :relation, :birthday, :allocated_percentage

  enum relation: ["Spouse", "Daughter", "Son", "Mother", "Father", "Sibling", "Gaurdian", "Pet", "Charity"]
end
