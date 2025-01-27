class CreateSneakers < ActiveRecord::Migration[8.0]
  def change
    create_table :sneakers do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.string :size
      t.string :color
      t.references :brand, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :stock

      t.timestamps
    end
  end
end
