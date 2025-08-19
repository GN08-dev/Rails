class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :descripcion
      t.integer :price

      t.timestamps
    end
  end
end
