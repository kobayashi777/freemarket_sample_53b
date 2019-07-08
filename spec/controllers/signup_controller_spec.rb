require 'rails_helper'

describe SignupController do
  let(:user) { create(:user) }

  context 'log in' do
    before do
      login user
    end

    describe 'GET #index' do
      it "redirect_to the top page" do
        get :index
        expect(response).to redirect_to products_path
      end
    end

    describe 'GET #registration' do
      it "redirect_to the top page" do
        get :registration
        expect(response).to redirect_to products_path
      end
    end

    describe 'GET #phone' do
      context 'registrationでの入力クエリに不備がない場合' do
        it "redirect_to the top page" do
          get :phone, params: {user: attributes_for(:user)}
          expect(response).to redirect_to products_path
        end
      end

      context 'registrationでの入力クエリに不備がある場合' do
        it "redirect_to the top page" do
          get :phone, params: {user: attributes_for(:user, nickname: nil)}
          expect(response).to redirect_to products_path
        end
      end
    end
    describe 'GET #address' do
      context 'phoneでの入力クエリに不備がない場合' do
        it "redirect_to the top page" do
          get :address,
          params: {
            user: {
              phone_number: "09012345678"
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12"
          }
          expect(response).to redirect_to products_path
        end
      end
      
      context 'phoneでの入力クエリに不備がある場合' do
        it "redirect_to the top page" do
          get :address,
          params: {
            user: {
              phone_number: ""
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12"
          }
          expect(response).to redirect_to products_path
        end
      end
    end
    
    describe 'GET #credit' do
      context 'addressでの入力クエリに不備がない場合' do
        it "redirect_to the top page" do
          get :credit,
          params: {
            user: {
              address_last_name: "山田",
              address_first_name: "彩",
              address_last_name_kana: "ヤマダ",
              address_first_name_kana: "アヤ",
              address_number: "111-1111",
              address_prefecture: "東京都",
              address_name: "渋谷区",
              address_block: "渋谷",
              address_building: "アジアビル",
              address_phone_number: "11111111111"
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12",
            phone_number: "09012345678"
          }
          expect(response).to redirect_to products_path
        end
      end
      
      context 'addressでの入力クエリに不備がある場合' do
        it "redirect_to the top page" do
          get :credit,
          params: {
            user: {
              address_last_name: "",
              address_first_name: "彩",
              address_last_name_kana: "ヤマダ",
              address_first_name_kana: "アヤ",
              address_number: "111-1111",
              address_prefecture: "東京都",
              address_name: "渋谷区",
              address_block: "渋谷",
              address_building: "アジアビル",
              address_phone_number: "11111111111"
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12",
            phone_number: "09012345678"
          }
          expect(response).to redirect_to products_path
        end
      end
    end
    
    describe 'POST #create' do
      context 'creditでの入力クエリに不備がない場合' do
        it "redirect_to the top page" do
          post :create, 
          params: {
            user: {
              credit_attributes: {
                card_number: "1111222233334444",
                validated_date_month: "12",
                validated_date_year: "19",
                security_code: "111"
              }
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12",
            phone_number: "11111111111",
            address_last_name: "山田",
            address_first_name: "彩",
            address_last_name_kana: "ヤマダ",
            address_first_name_kana: "アヤ",
            address_number: "111-1111",
            address_prefecture: "東京都",
            address_name: "渋谷区",
            address_block: "渋谷",
            address_building: "アジアビル",
            address_phone_number: "11111111111"
          }
          expect(response).to redirect_to products_path
        end
      end

      context 'creditでの入力クエリに不備がある場合' do
        it "redirect_to the top page" do
          post :create, 
          params: {
            user: {
              credit_attributes: {
                card_number: "",
                validated_date_month: "12",
                validated_date_year: "19",
                security_code: "111"
              }
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12",
            phone_number: "11111111111",
            address_last_name: "山田",
            address_first_name: "彩",
            address_last_name_kana: "ヤマダ",
            address_first_name_kana: "アヤ",
            address_number: "111-1111",
            address_prefecture: "東京都",
            address_name: "渋谷区",
            address_block: "渋谷",
            address_building: "アジアビル",
            address_phone_number: "11111111111"
          }
          expect(response).to redirect_to products_path
        end
      end
    end

    describe 'GET #done' do
      it "redirect_to the top page" do
        get :done
        expect(response).to redirect_to products_path
      end
    end
  end

  context 'log_out' do
    describe 'GET #index' do
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #registration' do
      it "renders the :registration template" do
        get :registration
        expect(response).to render_template :registration
      end
    end

    describe 'GET #phone' do
      context 'registrationでの入力に不備がない場合' do
        it "renders the :phone template" do
          get :phone, params: {user: attributes_for(:user)}
          expect(response).to render_template :phone
        end
      end

      context 'registrationの入力に不備がある場合' do
        it "renders the :registration template" do
          get :phone, params: {user: attributes_for(:user, nickname: nil)}
          expect(response).to render_template :registration
        end
      end
    end
    
    describe 'GET #address' do
      context 'phoneでの入力に不備がない場合' do
        it "renders the :address template" do
          get :address,
          params: {
            user: {
              phone_number: "09012345678"
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12"
          }
          expect(response).to render_template :address
        end
      end
      
      context 'phoneでの入力に不備がある場合' do
        it "renders the :phone template" do
          get :address,
          params: {
            user: {
              phone_number: ""
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12"
          }
          expect(response).to render_template :phone
        end
      end
    end
    
    describe 'GET #credit' do
      context 'addressでの入力に不備がない場合' do
        it "renders the :credit template" do
          get :credit,
          params: {
            user: {
              address_last_name: "山田",
              address_first_name: "彩",
              address_last_name_kana: "ヤマダ",
              address_first_name_kana: "アヤ",
              address_number: "111-1111",
              address_prefecture: "東京都",
              address_name: "渋谷区",
              address_block: "渋谷",
              address_building: "アジアビル",
              address_phone_number: "11111111111"
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12",
            phone_number: "09012345678"
          }
          expect(response).to render_template :credit
        end
      end
      
      context 'addressでの入力に不備がある場合' do
        it "renders the :credit template" do
          get :credit,
          params: {
            user: {
              address_last_name: "",
              address_first_name: "彩",
              address_last_name_kana: "ヤマダ",
              address_first_name_kana: "アヤ",
              address_number: "111-1111",
              address_prefecture: "東京都",
              address_name: "渋谷区",
              address_block: "渋谷",
              address_building: "アジアビル",
              address_phone_number: "11111111111"
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12",
            phone_number: "09012345678"
          }
          expect(response).to render_template :address
        end
      end
    end
    
    describe 'POST #create' do
      context 'creditでの入力に不備がなく、sns認証でない場合' do
        it "renders the :done template" do
          post :create, 
          params: {
            user: {
              credit_attributes: {
                card_number: "1111222233334444",
                validated_date_month: "12",
                validated_date_year: "19",
                security_code: "111"
              }
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12",
            phone_number: "11111111111",
            address_last_name: "山田",
            address_first_name: "彩",
            address_last_name_kana: "ヤマダ",
            address_first_name_kana: "アヤ",
            address_number: "111-1111",
            address_prefecture: "東京都",
            address_name: "渋谷区",
            address_block: "渋谷",
            address_building: "アジアビル",
            address_phone_number: "11111111111"
          }
          expect(response).to redirect_to done_signup_index_path
        end

        it "creats a user record in DB" do
          expect{
            post :create, 
            params: {
              user: {
                credit_attributes: {
                  card_number: "1111222233334444",
                  validated_date_month: "12",
                  validated_date_year: "19",
                  security_code: "111"
                }
              }
            },
            session: {
              nickname: "abe",
              email: "kkk@gmail.com",
              password: "00000000",
              password_confirmation: "00000000",
              last_name: "山田",
              first_name: "彩",
              last_name_kana: "ヤマダ",
              first_name_kana: "アヤ",
              birthdate_year: "1990",
              birthdate_month: "12",
              birthdate_day: "12",
              phone_number: "11111111111",
              address_last_name: "山田",
              address_first_name: "彩",
              address_last_name_kana: "ヤマダ",
              address_first_name_kana: "アヤ",
              address_number: "111-1111",
              address_prefecture: "東京都",
              address_name: "渋谷区",
              address_block: "渋谷",
              address_building: "アジアビル",
              address_phone_number: "11111111111"
            }
          }.to change(User, :count).by(1)
        end

        it "creats a credit record in DB" do
          expect{
            post :create, 
            params: {
              user: {
                credit_attributes: {
                  card_number: "1111222233334444",
                  validated_date_month: "12",
                  validated_date_year: "19",
                  security_code: "111"
                }
              }
            },
            session: {
              nickname: "abe",
              email: "kkk@gmail.com",
              password: "00000000",
              password_confirmation: "00000000",
              last_name: "山田",
              first_name: "彩",
              last_name_kana: "ヤマダ",
              first_name_kana: "アヤ",
              birthdate_year: "1990",
              birthdate_month: "12",
              birthdate_day: "12",
              phone_number: "11111111111",
              address_last_name: "山田",
              address_first_name: "彩",
              address_last_name_kana: "ヤマダ",
              address_first_name_kana: "アヤ",
              address_number: "111-1111",
              address_prefecture: "東京都",
              address_name: "渋谷区",
              address_block: "渋谷",
              address_building: "アジアビル",
              address_phone_number: "11111111111",
              provider: "aaa",
              uid: "1111111111"
            }
          }.to change(Credit, :count).by(1)
        end

        it "does not creat a sns_credentail record in DB" do
          expect{
            post :create, 
            params: {
              user: {
                credit_attributes: {
                  card_number: "1111222233334444",
                  validated_date_month: "12",
                  validated_date_year: "19",
                  security_code: "111"
                }
              }
            },
            session: {
              nickname: "abe",
              email: "kkk@gmail.com",
              password: "00000000",
              password_confirmation: "00000000",
              last_name: "山田",
              first_name: "彩",
              last_name_kana: "ヤマダ",
              first_name_kana: "アヤ",
              birthdate_year: "1990",
              birthdate_month: "12",
              birthdate_day: "12",
              phone_number: "11111111111",
              address_last_name: "山田",
              address_first_name: "彩",
              address_last_name_kana: "ヤマダ",
              address_first_name_kana: "アヤ",
              address_number: "111-1111",
              address_prefecture: "東京都",
              address_name: "渋谷区",
              address_block: "渋谷",
              address_building: "アジアビル",
              address_phone_number: "11111111111",
              provider: nil,
              uid: nil
            }
          }.not_to change(SnsCredential, :count)
        end
      end

      context 'creditでの入力に不備がなく、sns認証の場合' do
        it "creats a sns_credential record in DB" do
          expect{
            post :create, 
            params: {
              user: {
                credit_attributes: {
                  card_number: "1111222233334444",
                  validated_date_month: "12",
                  validated_date_year: "19",
                  security_code: "111"
                }
              }
            },
            session: {
              nickname: "abe",
              email: "kkk@gmail.com",
              password: "00000000",
              password_confirmation: "00000000",
              last_name: "山田",
              first_name: "彩",
              last_name_kana: "ヤマダ",
              first_name_kana: "アヤ",
              birthdate_year: "1990",
              birthdate_month: "12",
              birthdate_day: "12",
              phone_number: "11111111111",
              address_last_name: "山田",
              address_first_name: "彩",
              address_last_name_kana: "ヤマダ",
              address_first_name_kana: "アヤ",
              address_number: "111-1111",
              address_prefecture: "東京都",
              address_name: "渋谷区",
              address_block: "渋谷",
              address_building: "アジアビル",
              address_phone_number: "11111111111",
              provider: "aaa",
              uid: "1111111111"
            }
          }.to change(SnsCredential, :count).by(1)
        end
      end

      context 'creditでの入力に不備がある場合' do
        it "renders the :credit template" do
          post :create, 
          params: {
            user: {
              credit_attributes: {
                card_number: "",
                validated_date_month: "12",
                validated_date_year: "19",
                security_code: "111"
              }
            }
          },
          session: {
            nickname: "abe",
            email: "kkk@gmail.com",
            password: "00000000",
            password_confirmation: "00000000",
            last_name: "山田",
            first_name: "彩",
            last_name_kana: "ヤマダ",
            first_name_kana: "アヤ",
            birthdate_year: "1990",
            birthdate_month: "12",
            birthdate_day: "12",
            phone_number: "11111111111",
            address_last_name: "山田",
            address_first_name: "彩",
            address_last_name_kana: "ヤマダ",
            address_first_name_kana: "アヤ",
            address_number: "111-1111",
            address_prefecture: "東京都",
            address_name: "渋谷区",
            address_block: "渋谷",
            address_building: "アジアビル",
            address_phone_number: "11111111111"
          }
          expect(response).to render_template :credit
        end
      end
    end
  end
end