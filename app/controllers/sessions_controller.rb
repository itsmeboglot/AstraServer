class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: :create
  def create
    user = User.find_by(login: params[:login])

    if user
      if user.authenticate(params[:password])
        token = user.generate_jwt
        render json: { token: token }
      else
        render json: { error: 'Invalid password' }, status: :unauthorized
      end
    else
      user = User.create(login: params[:login], password: params[:password])
      if user.valid?
        token = user.generate_jwt
        render json: { token: token }, status: :created
      else
        render json: { error: user.errors.full_messages.join(', ') }, status: :unauthorized
      end
    end
  end
end