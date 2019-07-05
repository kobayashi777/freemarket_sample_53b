FactoryBot.define do

  factory :user do
    nickname                {"abe"}
    email                   {"kkk@gmail.com"}
    password                {"00000000"}
    password_confirmation   {"00000000"}
    last_name               {"山田"}
    first_name              {"彩"}
    last_name_kana          {"ヤマダ"}
    first_name_kana         {"アヤ"}
    birthdate_year          {"1990"}
    birthdate_month         {"12"} 
    birthdate_day           {"12"}
    phone_number            {"11111111111"}
    address_last_name       {"山田"}
    address_first_name      {"彩"}
    address_last_name_kana  {"ヤマダ"}
    address_first_name_kana {"アヤ"}
    address_number          {"111-1111"}
    address_prefecture      {"東京都"}
    address_name            {"渋谷区"}
    address_block           {"渋谷"}
    address_building        {"アジアビル"}
    address_phone_number    {"11111111111"}
  end

end