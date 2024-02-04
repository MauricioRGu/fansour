class CreateAssinaturas < ActiveRecord::Migration[7.0]
  def change
    create_table :assinaturas do |t|
      t.references :user, null: false, foreign_key: true
      t.references :criador, null: false, foreign_key: {to_table: :users}
      t.datetime :dt_inicio, null: false
      t.datetime :dt_fim, null: false
      t.float :valor

      t.timestamps
    end
  end
end
