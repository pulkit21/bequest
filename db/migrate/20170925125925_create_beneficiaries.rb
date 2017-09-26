class CreateBeneficiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :beneficiaries, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.integer :relation
      t.integer :allocated_percentage
      t.date :birthday
      t.references :insurance, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
