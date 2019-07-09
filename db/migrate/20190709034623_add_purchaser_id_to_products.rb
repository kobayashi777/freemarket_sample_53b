class AddPurchaserIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :purchaser_id, :integer
  end
end
