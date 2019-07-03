class Credit < ApplicationRecord
  # 有効期限（年）
  enum validated_date_year: {
    "19":19,"20":20,"21":21,"22":22,"23":23,"24":24,"25":26
  }, _suffix: true

  # 有効期限（月）
  enum validated_date_month: {
    "1":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"10":10,"11":11,"12":12
  }, _suffix: true

  # アソシエーション
  belongs_to :user, optional: true

  # バリデーション
  VALID_CARD_NUMBER_REGEX =        /\A\d{14,16}\z/   
  VALID_SECRET_CODE_REGEX =        /\A\d{3,4}\z/ 
  validates :card_number,          presence: true, format: { with: VALID_CARD_NUMBER_REGEX }
  validates :validated_date_month, presence: true
  validates :validated_date_year,  presence: true
  validates :security_code,        presence: true, format: { with: VALID_SECRET_CODE_REGEX }
end
