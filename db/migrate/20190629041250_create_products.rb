class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :product_name, null: false, index: true
      t.text :product_introduction, null: false
      t.integer :category_id, limit: 8
      t.integer :products_size_id, limit: 8
      t.integer :brand_id, limit: 8
      t.integer :product_status, null: false, default: 0
      t.integer :delivery_charge, null: false, default: 0
      t.integer :delivery_area, null: false, default: 0
      t.string :price, null: false
      t.integer :delivery_days, null: false, default: 0
      t.integer :delivery_method, null: false, default: 0
      t.integer :trading_state, null: false, default: 0
      t.timestamps null: false
    end
    add_foreign_key :products, :categories
    add_foreign_key :products, :products_sizes
    add_foreign_key :products, :brands
  end
end
