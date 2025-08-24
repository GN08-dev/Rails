class CreateFavorites < ActiveRecord::Migration[8.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
    # creando indice que abarca dos columnas t anto user_id como product_id para evitar que se repita el mismo producto en favorito
    add_index :favorites, [ :user_id, :product_id ], unique: true
  end
end
