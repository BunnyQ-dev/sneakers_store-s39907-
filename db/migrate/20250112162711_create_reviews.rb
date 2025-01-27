class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.references :sneaker, null: false, foreign_key: true
      t.string :user_name

      t.timestamps
    end
  end
end
