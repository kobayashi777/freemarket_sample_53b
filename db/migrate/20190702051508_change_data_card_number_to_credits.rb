class ChangeDataCardNumberToCredits < ActiveRecord::Migration[5.2]
  def change
    change_column :credits, :card_number, :integer, null: false, limit: 8
  end
end
