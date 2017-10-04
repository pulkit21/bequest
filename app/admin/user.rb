ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

index do
  # selectable_column
  # id_column
  column :first_name
  column :last_name
  column :email
  column :phone_number
  column "Street" do |user|
    user.address
  end
  column :city
  column :state
  column :zipcode
  column :gender do |user|
    user.insurances.first.gender if user.insurances.present? && user.insurances.first.gender.present?
  end
  column :age  do |user|
    user.insurances.first.current_age if user.insurances.present? && user.insurances.first.current_age.present?
  end
  column :coverage_amount  do |user|
    user.insurances.first.coverage_amount if user.insurances.present? && user.insurances.first.coverage_amount.present?
  end
  column :payment_amount  do |user|
    user.insurances.first.coverage_payment if user.insurances.present? && user.insurances.first.coverage_payment.present?
  end
  column :payment_frequency  do |user|
    user.insurances.first.payment_frequency.upcase if user.insurances.present? && user.insurances.first.payment_frequency.present?
  end
  column :last_page_completed  do |user|
    user.insurances.first.aasm_state if user.insurances.present? && user.insurances.first.aasm_state.present?
  end
  column :payment_received  do |user|
  end
  column :documents_signed  do |user|
    user.insurances.first.docs_status  if user.insurances.present? && user.insurances.first.docs_status.present?
  end
  # actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :city
  filter :state
  filter :gender
  filter :age
  filter :payment_received
  filter :documents_signed

end
