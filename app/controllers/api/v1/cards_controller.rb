# frozen_string_literal: true

module Api
  module V1
    class CardsController < ApplicationController

      # GET /groups/:group_id/bunches/:bunch_id/cards
      def index
        bunch = Bunch.find_by(id: params[:bunch_id])

        if bunch_exists(bunch, bunch.group)
          cards = bunch.cards
          render json: cards.as_json
        end
      end

      # POST /groups/:group_id/bunches/:bunch_id/cards
      def create
        bunch = Bunch.find_by(id: params[:bunch_id])

        if bunch_exists(bunch, bunch.group)
          result = ::Card::Create.call(create_params, bunch)
          return render json: { errors: result.errors }, status: :bad_request if result.errors.any?

          render json: { response: result.card.as_json }, status: :ok
        end
      end

      private

      def create_params
        params.permit(%i[word definition example])
      end

      def group_exists(group, user)
        if group && group.belongs_to(user)
          return true
        end

        render json: { error: "No such group with id <#{params[:group_id]}>" }, status: :bad_request
        false
      end

      def bunch_exists(bunch, group)
        if bunch && bunch.belongs_to(group) && group.belongs_to(@current_user)
          return true
        end

        render json: { error: "No such bunch with id <#{params[:group_id]}>" }, status: :bad_request
        false
      end

    end
  end
end
