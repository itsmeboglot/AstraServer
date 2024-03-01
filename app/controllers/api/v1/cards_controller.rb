# frozen_string_literal: true

module Api
  module V1
    class CardsController < ApplicationController

      # GET /groups/:group_id/cards
      def index
        group = Group.find_by(id: params[:group_id])

        if !group || !group.is_mine(@current_user)
          render json: {error: "No such group with id <#{params[:group_id]}>"}, status: :bad_request
          return
        end

        cards = group.cards
        render json: cards.as_json
      end

      def create

      end
    end
  end
end
