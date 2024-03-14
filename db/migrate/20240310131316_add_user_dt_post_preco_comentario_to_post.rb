class AddUserDtPostPrecoComentarioToPost < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
    add_column :posts, :preco, :float, default: nil
    add_column :posts, :dt_post, :datetime, default: nil
    add_column :posts, :comentario, :boolean, default: true
  end
end
