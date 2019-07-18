class ChangeColumnToProduct < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :exhibitor_id, :integer, null: false
  end
end
