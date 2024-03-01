# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController

      skip_before_action :authenticate_request

      def create
        user = User.find_by(email: params[:email])

        if user == nil
          user = User.create(email: params[:email], password: params[:password])

          if user.valid?
            token = user.generate_jwt
            render json: { token: token }, status: :created
          else
            render json: { error: user.errors.full_messages.join(', ') }, status: :bad_request
          end
        else
          render json: { error: 'User already exists' }, status: :bad_request
        end
      end

      def verify
        user = User.find_by(email: params[:email])

        if user
          if user.authenticate(params[:password])
            token = user.generate_jwt
            render json: { token: token }
          else
            render json: { error: 'Invalid password' }, status: :bad_request
          end
        else
          render json: { error: 'User does not exist' }, status: :bad_request
        end
      end

    end
  end
end
