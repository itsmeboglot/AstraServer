class TestUserController < ApplicationController
  def get_test_user
    user = User.first
    render json: user
  end
end
