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
  column :gender
  column :age
  column :coverage_area
  column :payment_amount
  column :payment_frequesncy
  column :last_page_completed
  column :payment_received
  column :documents_signed
  actions
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
