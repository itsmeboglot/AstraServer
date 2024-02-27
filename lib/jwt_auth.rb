require 'jwt'

module JwtAuth
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 5.minutes.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded_token
  end
end