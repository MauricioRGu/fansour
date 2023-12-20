class AddPlanosToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :valor1, :float, default: 0
    add_column :users, :desc1, :float, default: 0
    add_column :users, :valor3, :float, default: 0
    add_column :users, :desc3, :float, default: 0
    add_column :users, :valor6, :float, default: 0
    add_column :users, :desc6, :float, default: 0
  end
end
