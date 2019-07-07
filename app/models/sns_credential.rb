class SnsCredential < ApplicationRecord
  belongs_to :user
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create
  end
end
