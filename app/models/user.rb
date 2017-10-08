class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :insurances
  validates_presence_of :first_name, :last_name #, :address, :city, :state, :zipcode

  before_create :populate_city_and_state
  before_create :check_valid_zipcode


  # Check for the zipcode policy coverage
  def check_valid_zipcode
    zip_code = State.find_by_abbr("VT").zipcodes.find_by_code(self.zipcode)
    unless zip_code.present?
      errors.add(:zipcode, "Invalid zipcode!")
      raise ActiveRecord::Rollback
    end
  end

  def populate_city_and_state
    zipcode = Zipcode.find_by_code self.zipcode
    self.city = zipcode.city
    self.state = zipcode.state.name
  end

  # def check_valid_zipcode
  #   zip_code = State.find_by_abbr("NC").zipcodes.find_by_code(self.zipcode)
  #   if zip_code.present? && zip_code.inactive?
  #     errors.add(:zipcode, "Sorry, we do not offer coverage to individuals in your zip code.")
  #     raise ActiveRecord::Rollback
  #   elsif !zip_code.present?
  #     errors.add(:zipcode, "Invalid zipcode!")
  #     raise ActiveRecord::Rollback
  #   end
  # end

  def active_zipcode?
    zip = State.find_by_abbr("VT").zipcodes.find_by_code(self.zipcode)
    active_zip = zip.present? && zip.active?
    active_zip
  end


  def full_name
    "#{first_name} #{last_name}"
  end

  # Signup without password
  def password_required?
    new_record? ? false : super
  end
end
