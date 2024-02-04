class AddPlanToAssinatura < ActiveRecord::Migration[7.0]
  def change
    add_column :assinaturas, :plan, :integer, null: false
  end
end
