require 'jwt'

module JwtAuth
  SECRET_KEY = ENV['SECRET_KEY_BASE']

  def self.encode(payload, exp = 60.day.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    puts("SECRET_KEY: #{SECRET_KEY}")
    decoded_token = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded_token
  end
end