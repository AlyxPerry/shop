class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.decimal :price
      t.integer :quantity
      t.string :name
      t.text :description
      t.string :image
      t.string :brand
      t.integer :category_id
      t.integer :rating

      t.timestamps
    end
  end
end
