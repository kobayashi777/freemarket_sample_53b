require 'rails_helper'

describe User do
  describe '#create' do
    # 全てのインプットありの場合
    it "is valid with all inputs" do
      user = build(:user)
      expect(user).to be_valid
    end
    # ニックネーム関連
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    
    it "is invalid with a nickname that has more than 20 characters " do
      user = build(:user, nickname: Faker::Internet.username(21))
      user.valid?
      expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
    end

    # メールアドレス関連
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
  
    it "is invalid with a email that has not @ mark" do
      user = build(:user, email: "aaabbb.cc")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with a email that has not a local" do
      user = build(:user, email: "@bbb.cc")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with a email that has not a domain" do
      user = build(:user, email: "aaa@")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with a email that has not the latter domain" do
      user = build(:user, email: "aaa@bbb")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "is invalid with a email that has not the former domain" do
      user = build(:user, email: "aaa@.cc")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
    
    it "is invalid with a duplicate email" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    # パスワード関連
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end
    
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードが一致しません")
    end
    
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: Faker::Internet.password(1, 5))
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end
    
    it "is invalid with a password that has more than 128 characters " do
      user = build(:user, password: Faker::Internet.password(129))
      user.valid?
      expect(user.errors[:password]).to include("は128文字以内で入力してください")
    end
    
    # 姓
    it "is invalid without a last_name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end
    
    # 名
    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end
    
    # 姓カナ
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください")
    end
    
    # 名カナ
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end
    
    #生年月日（年）
    it "is invalid without a birthdate_year" do
      user = build(:user, birthdate_year: "--")
      user.valid?
      expect(user.errors[:birthdate_year]).to include("は数値で入力してください")
    end
    
    #生年月日（月）
    it "is invalid without a birthdate_month" do
      user = build(:user, birthdate_month: "--")
      user.valid?
      expect(user.errors[:birthdate_month]).to include("は数値で入力してください")
    end
    
    #生年月日（日）
    it "is invalid without a birthdate_day" do
      user = build(:user, birthdate_day: "--")
      user.valid?
      expect(user.errors[:birthdate_day]).to include("は数値で入力してください")
    end

    # 電話番号関連
    it "is invalid without a phone_number" do
      user = build(:user, phone_number: nil)
      user.valid?
      expect(user.errors[:phone_number]).to include("を入力してください")
    end
    
    it "is invalid with a phone_number that has less than 10 characters" do
      user = build(:user, phone_number: Faker::Number.number(9))
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end
    
    it "is invalid with a phone_number that has more than 11 characters" do
      user = build(:user, phone_number: Faker::Number.number(12))
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end
    
    it "is invalid with a duplicate phone_number" do
      user = create(:user)
      another_user = build(:user, phone_number: user.phone_number)
      another_user.valid?
      expect(another_user.errors[:phone_number]).to include("はすでに存在します")
    end
    
    # 住所（姓）
    it "is invalid without a address_last_name" do
      user = build(:user, address_last_name: nil)
      user.valid?
      expect(user.errors[:address_last_name]).to include("を入力してください")
    end
    
    # 住所（名）
    it "is invalid without a address_first_name" do
      user = build(:user, address_first_name: nil)
      user.valid?
      expect(user.errors[:address_first_name]).to include("を入力してください")
    end
    
    # 住所（姓カナ）
    it "is invalid without a address_last_name_kana" do
      user = build(:user, address_last_name_kana: nil)
      user.valid?
      expect(user.errors[:address_last_name_kana]).to include("を入力してください")
    end
    
    # 住所（名カナ）
    it "is invalid without a address_first_name_kana" do
      user = build(:user, address_first_name_kana: nil)
      user.valid?
      expect(user.errors[:address_first_name_kana]).to include("を入力してください")
    end
    
    # 郵便番号関連
    it "is invalid without a address_number" do
      user = build(:user, address_number: nil)
      user.valid?
      expect(user.errors[:address_number]).to include("を入力してください")
    end
    
    it "is invalid with a address_number that has not a hyphen" do
      user = build(:user, address_number: "0000000")
      user.valid?
      expect(user.errors[:address_number]).to include("は不正な値です")
    end
    
    it "is invalid with a address_number that has not the former numbers" do
      user = build(:user, address_number: "-0000")
      user.valid?
      expect(user.errors[:address_number]).to include("は不正な値です")
    end
    
    it "is invalid with a address_number that has not the latter numbers" do
      user = build(:user, address_number: "000-")
      user.valid?
      expect(user.errors[:address_number]).to include("は不正な値です")
    end
    
    # 都道府県
    it "is invalid without a address_prefecture" do
      user = build(:user, address_prefecture: nil)
      user.valid?
      expect(user.errors[:address_prefecture]).to include("を入力してください")
    end
    
    # 市区町村
    it "is invalid without a address_name" do
      user = build(:user, address_name: nil)
      user.valid?
      expect(user.errors[:address_name]).to include("を入力してください")
    end
    
    # 番地
    it "is invalid without a address_block" do
      user = build(:user, address_block: nil)
      user.valid?
      expect(user.errors[:address_block]).to include("を入力してください")
    end
    
    # 建物名
    it "is valid without a address_building" do
      user = build(:user, address_building: nil)
      expect(user).to be_valid
    end
    
    # 住所（電話番号）関連
    it "is valid without a address_phone_number" do
      user = build(:user, address_phone_number: nil)
      expect(user).to be_valid
    end
    
    it "is valid with a duplicate address_phone_number" do
      user = create(:user)
      another_user = build(:user, email: user.address_phone_number)
      another_user.valid?
      expect(user).to be_valid
    end
    
    it "is invalid with a address_phone_number that has less than 10 characters" do
      user = build(:user, address_phone_number: Faker::Number.number(9))
      user.valid?
      expect(user.errors[:address_phone_number]).to include("は不正な値です")
    end
    
    it "is invalid with a address_phone_number that has more than 11 characters" do
      user = build(:user, address_phone_number: Faker::Number.number(12))
      user.valid?
      expect(user.errors[:address_phone_number]).to include("は不正な値です")
    end

  end
end