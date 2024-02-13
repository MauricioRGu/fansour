class ChangeCriadorToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.rename :criador, :perfil_criador
    end
  end
end
