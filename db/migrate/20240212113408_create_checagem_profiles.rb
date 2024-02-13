class CreateChecagemProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :checagem_profiles do |t|
      t.boolean :analisado, default: false
      t.boolean :aprovado, default: false
      t.string :observacao
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
