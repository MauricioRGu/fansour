class ChangeColumnValor1ToUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :valor1, :decimal, precision: 5, scale: 2, default: 0
  end
end
