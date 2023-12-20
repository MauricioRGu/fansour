class AddCamposToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nome_completo, :string
    add_column :users, :nome_publico, :string
    add_column :users, :cpf, :string
    add_column :users, :dt_nascimento, :date
    add_column :users, :telefone, :string
    add_column :users, :pais, :string
    add_column :users, :cep, :string
    add_column :users, :estado, :string
    add_column :users, :cidade, :string
    add_column :users, :endereco, :string
    add_column :users, :bairro, :string
    add_column :users, :numero, :integer
    add_column :users, :complemento, :string
    add_column :users, :criador, :boolean, :default => false
    add_column :users, :dt_verificacao, :datetime
    add_column :users, :publico, :boolean, :default => false
    add_column :users, :desativado, :boolean, :default => false
    add_column :users, :descricao, :text
  end
end
