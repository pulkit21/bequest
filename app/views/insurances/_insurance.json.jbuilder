json.extract! insurance, :id, :tobacco_product, :health_condition, :gender, :birthday,
  :height, :weight, :coverage_amount, :payment_frequency, :terms_and_services, :aasm_state, :created_at, :updated_at

json.user do
  json.id   insurance.user.id
  json.email insurance.user.email
end

