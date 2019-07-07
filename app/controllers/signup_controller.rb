class SignupController < ApplicationController
  before_action :save_to_session_before_phone, only: :phone
  before_action :save_to_session_before_address, only: :address
  before_action :save_to_session_before_credit, only: :credit
  before_action :save_to_session_before_done, only: :create

  def index # 新規会員登録方法画面
    session[:flag] = "signup"
  end

  def registration # 会員情報登録画面
    @user = User.new # 新規インスタンス作成
    session[:birthdate_year] = "--" #生年月日の年、初期値設定
    session[:birthdate_month] = "--" #生年月日の月、初期値設定
    session[:birthdate_day] = "--" #生年月日の日、初期値設定
  end


  def phone # 電話番号の登録画面
    @user = User.new # 新規インスタンス作成
  end
  
  def address # 発送元・お届け先登録画面
    @user = User.new # 新規インスタンス作成
  end
  
  def credit # 支払い方法登録画面
    @user = User.new # 新規インスタンス作成
    @user.build_credit # 新規creditsテーブルのインスタンス作成
  end
  
  def create # 支払い方法登録画面で"次へ進む"を押すと動くアクション
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthdate_year: session[:birthdate_year], 
      birthdate_month: session[:birthdate_month], 
      birthdate_day: session[:birthdate_day], 
      phone_number: session[:phone_number], 
      address_last_name: session[:address_last_name], 
      address_first_name: session[:address_first_name], 
      address_last_name_kana: session[:address_last_name_kana], 
      address_first_name_kana: session[:address_first_name_kana], 
      address_number: session[:address_number], 
      address_prefecture: session[:address_prefecture], 
      address_name: session[:address_name], 
      address_block: session[:address_block], 
      address_building: session[:address_building], 
      address_phone_number: session[:address_phone_number], 
    )
    @user.build_credit(user_params[:credit_attributes]) # creditsテーブルのインスタンス作成
    @user.sns_credentials.build(provider: session[:provider], uid: session[:uid]) if session[:provider] && session[:uid]
    if @user.save
      sign_in @user
      redirect_to done_signup_index_path
    else
      render '/signup/registration'
    end
  end
    
private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :password, 
      :password_confirmation, 
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana, 
      :birthdate_year, 
      :birthdate_month, 
      :birthdate_day, 
      :phone_number,
      :address_last_name,
      :address_first_name,
      :address_last_name_kana,
      :address_first_name_kana,
      :address_number,
      :address_prefecture,
      :address_name,
      :address_block,
      :address_building,
      :address_phone_number,
      credit_attributes: [
      :id,
      :card_number,
      :validated_date_year, 
      :validated_date_month,
      :security_code
      ]
  )
  end

  def save_to_session_before_phone
    # registrationで入力した値をsessionに保存
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthdate_year] = user_params[:birthdate_year]
    session[:birthdate_month] = user_params[:birthdate_month]
    session[:birthdate_day] = user_params[:birthdate_day]
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthdate_year: session[:birthdate_year], 
      birthdate_month: session[:birthdate_month], 
      birthdate_day: session[:birthdate_day],
      phone_number: 12345678901,
      address_last_name: "AA", 
      address_first_name: "BB", 
      address_last_name_kana: "CC", 
      address_first_name_kana: "DD", 
      address_number: "000-0000", 
      address_prefecture: "北海道",
      address_name: "EE", 
      address_block: "FF",
      address_phone_number: 12345678901
    )
    render '/signup/registration' unless @user.valid?
  end
    
  def save_to_session_before_address
    # phoneで入力した値をsessionに保存
    session[:phone_number] = user_params[:phone_number]
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthdate_year: session[:birthdate_year], 
      birthdate_month: session[:birthdate_month], 
      birthdate_day: session[:birthdate_day],
      phone_number: session[:phone_number],
      address_last_name: "AA", 
      address_first_name: "BB", 
      address_last_name_kana: "CC", 
      address_first_name_kana: "DD", 
      address_number: "000-0000", 
      address_prefecture: "北海道",
      address_name: "EE", 
      address_block: "FF",
      address_phone_number: 12345678901
    )
    render '/signup/phone' unless @user.valid?
  end
      
  def save_to_session_before_credit
    # addressで入力した値をsessionに保存
    session[:address_last_name] = user_params[:address_last_name]
    session[:address_first_name] = user_params[:address_first_name]
    session[:address_last_name_kana] = user_params[:address_last_name_kana]
    session[:address_first_name_kana] = user_params[:address_first_name_kana]
    session[:address_number] = user_params[:address_number]
    session[:address_prefecture] = user_params[:address_prefecture]
    session[:address_name] = user_params[:address_name]
    session[:address_block] = user_params[:address_block]
    session[:address_building] = user_params[:address_building]
    session[:address_phone_number] = user_params[:address_phone_number]
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthdate_year: session[:birthdate_year], 
      birthdate_month: session[:birthdate_month], 
      birthdate_day: session[:birthdate_day],
      phone_number: session[:phone_number],
      address_last_name: session[:address_last_name], 
      address_first_name: session[:address_first_name], 
      address_last_name_kana: session[:address_last_name_kana], 
      address_first_name_kana: session[:address_first_name_kana], 
      address_number: session[:address_number], 
      address_prefecture: session[:address_prefecture], 
      address_name: session[:address_name], 
      address_block: session[:address_block], 
      address_building: session[:address_building], 
      address_phone_number: session[:address_phone_number]
    )
    render '/signup/address' unless @user.valid?
  end
        
  def save_to_session_before_done
    # creditで入力した値をsessionに保存
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      last_name: session[:last_name], 
      first_name: session[:first_name], 
      last_name_kana: session[:last_name_kana], 
      first_name_kana: session[:first_name_kana], 
      birthdate_year: session[:birthdate_year], 
      birthdate_month: session[:birthdate_month], 
      birthdate_day: session[:birthdate_day],
      phone_number: session[:phone_number],
      address_last_name: session[:address_last_name], 
      address_first_name: session[:address_first_name], 
      address_last_name_kana: session[:address_last_name_kana], 
      address_first_name_kana: session[:address_first_name_kana], 
      address_number: session[:address_number], 
      address_prefecture: session[:address_prefecture], 
      address_name: session[:address_name], 
      address_block: session[:address_block], 
      address_building: session[:address_building], 
      address_phone_number: session[:address_phone_number]
    )
    @user.build_credit(user_params[:credit_attributes])
    render '/signup/credit' unless @user.valid?
  end
end
          