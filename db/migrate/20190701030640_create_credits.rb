class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.integer :user_id, limit: 8
      t.integer :card_number, null: false
      t.integer :validated_date_month, null: false, default: 0
      t.integer :validated_date_year, null: false, default: 0
      t.integer :security_code, null: false
      t.timestamps
    end
    add_foreign_key :credits, :users
  end
end
