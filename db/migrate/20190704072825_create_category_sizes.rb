class CreateCategorySizes < ActiveRecord::Migration[5.2]
  def change
    create_table :category_sizes do |t|
      t.integer :category_id, limit: 8
      t.integer :products_size_id, limit: 8
      t.timestamps
    end
    add_foreign_key :category_sizes, :categories
    add_foreign_key :category_sizes, :products_sizes
  end
end
