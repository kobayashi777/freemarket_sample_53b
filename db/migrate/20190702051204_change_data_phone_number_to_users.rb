class ChangeDataPhoneNumberToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :phone_number, :integer, null: false, limit: 8
    add_index :users, :phone_number, unique: true
  end
end
