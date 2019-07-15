class ChangeDeliveryMethodToProduct < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :delivery_method, :string
  end
end
