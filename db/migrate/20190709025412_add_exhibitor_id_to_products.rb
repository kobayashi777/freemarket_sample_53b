class AddExhibitorIdToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :exhibitor_id, :integer
  end
end
