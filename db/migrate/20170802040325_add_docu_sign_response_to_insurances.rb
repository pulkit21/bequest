class AddDocuSignResponseToInsurances < ActiveRecord::Migration[5.1]
  def change
    add_column :insurances, :docusign_response, :jsonb
  end
end
