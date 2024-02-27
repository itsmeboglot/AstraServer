class User < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_secure_password

  def generate_jwt
    JwtAuth.encode(user_id: id)
  end
end