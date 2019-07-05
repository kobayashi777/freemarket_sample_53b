require 'rails_helper'

describe Credit do
  describe '#create' do

    # 全てのインプットありの場合
    it "is valid with a card_number, validated_date_month, validated_date_year, security_code" do
      user = build(:user)
      credit = build(:credit, user: user)
      expect(credit).to be_valid
    end

    # カード番号関連
    it "is invalid without a card_number" do
      user = build(:user)
      credit = build(:credit, card_number: nil, user: user)
      credit.valid?
      expect(credit.errors[:card_number]).to include("を入力してください")
    end

    it "is invalid with a card_number that has less than 14 characters " do
      user = build(:user)
      credit = build(:credit, card_number: Faker::Number.number(13), user: user)
      credit.valid?
      expect(credit.errors[:card_number]).to include("は不正な値です")
    end
    
    it "is invalid with a card_number that has more than 16 characters " do
      user = build(:user)
      credit = build(:credit, card_number: Faker::Number.number(17), user: user)
      credit.valid?
      expect(credit.errors[:card_number]).to include("は不正な値です")
    end
    
    # 有効期限（月）
    it "is invalid without a validated_date_month" do
      user = build(:user)
      credit = build(:credit, validated_date_month: nil, user: user)
      credit.valid?
      expect(credit.errors[:validated_date_month]).to include("を入力してください")
    end
    
    # 有効期限（年）
    it "is invalid without a validated_date_year" do
      user = build(:user)
      credit = build(:credit, validated_date_year: nil, user: user)
      credit.valid?
      expect(credit.errors[:validated_date_year]).to include("を入力してください")
    end
    
    # セキュリテイコード関連
    it "is invalid without a security_code" do
      user = build(:user)
      credit = build(:credit, security_code: nil, user: user)
      credit.valid?
      expect(credit.errors[:security_code]).to include("を入力してください")
    end

    it "is invalid with a security_code that has less than 3 characters " do
      user = build(:user)
      credit = build(:credit, security_code: Faker::Number.number(2), user: user)
      credit.valid?
      expect(credit.errors[:security_code]).to include("は不正な値です")
    end
    
    it "is invalid with a security_code that has more than 4 characters " do
      user = build(:user)
      credit = build(:credit, security_code: Faker::Number.number(5), user: user)
      credit.valid?
      expect(credit.errors[:security_code]).to include("は不正な値です")
    end

  end
end