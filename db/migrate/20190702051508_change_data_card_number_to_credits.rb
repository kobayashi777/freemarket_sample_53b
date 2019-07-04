class ChangeDataCardNumberToCredits < ActiveRecord::Migration[5.2]
  def up
    change_column :credits, :card_number, :integer, null: false, limit: 8
  end
end
