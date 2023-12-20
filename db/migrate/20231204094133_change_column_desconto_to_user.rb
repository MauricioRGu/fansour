class ChangeColumnDescontoToUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :desc1, :integer, default: 0
    change_column :users, :desc3, :integer, default: 0
    change_column :users, :desc6, :integer, default: 0
  end
end
