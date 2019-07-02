class ChangeDataPhoneNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :phone_number, :integer, null: false, unique: true, limit: 8
  end
end
