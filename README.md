# DB設計

## users table

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthdate_year|integer|null: false|
|birthdate_month|integer|null: false|
|birthdate_day|integer|null: false|
|phone_number|integer|null: false, unique: true, limit: 8|
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
|introduce|text|--|
|encrypted_password|string|null: false, defalut: ""|
|reset_password_token|string|--|
|reset_password_sent_at|datetime|--|
|remember_created_at|datetime|--|

### Association
- has_many :products
- has_many :sns_credentials
- has_one :credit
- accepts_nested_attributes_for :credit
***
## credits table

|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key: true, limit: 8|
|card_number|integer|null: false, limit: 8|
|validated_date_month|integer|null: false, default: 0|
|validated_date_year|integer|null: false, default: 0|
|security_code|integer|null: false|

### Association
- belongs_to :user
***
## sns_credentials table

|Column|Type|Options|
|------|----|-------|
|provider|string|--|
|uid|string|--|
|user_id|integer|foreign_key: true, limit: 8|
### Association
- belongs_to :user
***
## products table

|Column|Type|Options|
|------|----|-------|
|product_name|string|null: false, index: true|
|product_introduction|text|null: false|
|category_id|integer|foreign_key: true, limit: 8|
|products_size_id|integer|foreign_key: true, limit: 8|
|brand_id|integer|foreign_key: true, limit: 8|
|product_status|integer|null: false, default: 0|
|delivery_charge|integer|null: false, default: 0|
|delivery_area|integer|null: false, default: 0|
|price|string|null: false|
|delivery_days|integer|null: false, default: 0|
|exhibitor_id|integer|foreign_key: true, limit: 8|
|purchaser_id|integer|foreign_key: true, limit: 8|
|delivery_method|string|null: false|
|trading_state|integer|null: false, default: 0|

### Association
- has_many_attached :photos
- belongs_to :exhibitor, class_name: 'User', foreign_key: :exhibitor_id, optional: true
- belongs_to :purchaser, class_name: 'User', foreign_key: :purchaser_id, optional: true
- belongs_to :brand, optional: true
- belongs_to :category
- belongs_to :products_size, optional: true

***
## active_storage_blobs table

|Column|Type|Options|
|------|----|-------|
|key|string|null: false, index: true, unique: true|
|filename|string|null: false|
|content_type|string|null: false|
|metadata|text|--|
|byte_size|bigint|null: false|
|checksum|string|null: false|

***
## active_storage_attachments table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true, unique: true|
|record_type|string|null: false, index: true, unique: true|
|record_id|references|null: false, polymorphic: true, index: true, unique: true|
|blob_id|references|foreign_key: true|

***
## products_sizes table

|Column|Type|Options|
|------|----|-------|
|size|string|null: false, index: true|
|ancestry|string|index: true|

### Association
- has_many :category_sizes
- has_many :categories, through: :category_sizes
- has_many :products
- has_ancestry
***
## category_sizes table

|Column|Type|Options|
|------|----|-------|
|category_id|integer|foreign_key: true, limit: 8|
|products_size_id|integer|foreign_key: true, limit: 8|

### Association
- belongs_to :category
- belongs_to :products_size
***
## categories table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|ancestory|string|index: true|

### Association
- has_many :products
- has_many :category_sizes
- has_many :products_sizes, through: :category_sizes
- has_ancestry
***
## brands table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|
|category_id|references|foreign_key: true|

### Association
- has_many :products
***
