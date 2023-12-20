class ChangeValor1ToUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :valor1, :float, default: 0
  end
end
