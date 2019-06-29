# DB設計

## users table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|password_confirmation|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthdate_year|integer|null: false|
|birthdate_month|integer|null: false|
|birthdate_day|integer|null: false|
|phone_number|integer|null: false, unique: true|
|address_last_name|string|null: false|
|address_first_name|string|null: false|
|address_last_name_kana|string|null: false|
|address_first_name_kana|string|null: false|
|address_number|string|null: false|
|address_prefecture|integer|null: false, default: 0|
|address_name|string|null: false|
|address_block|string|null: false|
|address_building|string|--|
|address_phone_number|integer|--|
|registration_date|timestamp|null: false|
|introduce|text|null: false|


### Association
- has_many :users_photos
- has_many :products
- has_many :credits, through: :users_credits
***
## creaidts table

|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false|
|validated_date_month|integer|null: false, default: 0|
|validated_date_year|integer|null: false, default: 0|
|security_code|integer|null: false|
|created_at|timestamp|null: false|

### Association
- has_many :users, through: :users_credits, dependent::destroy
***
## users_credits table

|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|credit_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :credit
***
## products table

|Column|Type|Options|
|------|----|-------|
|product_name|string|null: false, index: true|
|product_introduction|text|null: false|
|category_id|references|foreign_key: true|
|product_size_id|references|foreign_key: true|
|brand_id|references|foreign_key: true|
|product_status|integer|null: false, default: 0|
|delivery_charge|integer|null: false, default: 0|
|delivery_area|integer|null: false, default: 0|
|price|string|null: false|
|delivery_days|integer|null: false, default: 0|
|exhibitor_id|references|foreign_key: true|
|purchaser_id|references|foreign_key: true|
|delivery_method|integer|null: false, default: 0|
|trading_state|integer|null: false, default: 0|
|created_at|timestamp|null: false|
|updated_at|timestamp|null: false|

### Association
- has_many :products_photos, dependent::destroy
- belongs_to :user
- belongs_to :brand
- belongs_to :category
- belongs_to :product_size
***
## users_photos table

|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|photo|text|null: false|
|created_at|timestamp|null: false|
|updates_at|timestamp|null: false|

### Association
- belongs_to :user
***
## products_photos table

|Column|Type|Options|
|------|----|-------|
|product_id|references|foreign_key: true|
|photo|references|foreign_key: true|
|created_at|timestamp|null: false|
|updates_at|timestamp|null: false|

### Association
- belongs_to :product
***
## products_sizies table

|Column|Type|Options|
|------|----|-------|
|size|string|null: false, index: true|
|path|string|--|

### Association
- has_many :products
***
## categories table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|path|string|--|

### Association
- has_many :products
***
## brands table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|category_id|references|foreign_key: true|

### Association
- has_many :products
***
