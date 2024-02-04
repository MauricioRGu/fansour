class AddVencidaRenovacaoToAssinaturas < ActiveRecord::Migration[7.0]
  def change
    add_column :assinaturas, :vencida, :boolean, default: false
    add_column :assinaturas, :renovacao_automatica, :boolean, default: true
  end
end
