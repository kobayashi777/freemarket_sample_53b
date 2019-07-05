FactoryBot.define do

  factory :credit do
    card_number               {"1111222233334444"}
    validated_date_month      {"12"}
    validated_date_year       {"19"}
    security_code             {"111"}
  end

end