class CreateInsurances < ActiveRecord::Migration[5.1]
  def change
    create_table :insurances, id: :uuid do |t|
      t.boolean :tobacco_product
      t.boolean :health_condition
      t.boolean :gender
      t.date :birthday
      t.integer :height
      t.integer :weight
      t.integer :coverage_amount
      t.integer :payment_frequency
      t.boolean :terms_and_services
      t.references :user, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
