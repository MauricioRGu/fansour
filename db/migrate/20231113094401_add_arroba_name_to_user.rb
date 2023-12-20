class AddArrobaNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nome_arroba, :string
    
    add_index :users, :nome_arroba,  unique: true
  end
end
