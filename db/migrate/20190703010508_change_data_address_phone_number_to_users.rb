class ChangeDataAddressPhoneNumberToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :address_phone_number, :integer, limit: 8
  end
end
