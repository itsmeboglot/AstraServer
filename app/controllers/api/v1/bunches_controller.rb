# frozen_string_literal: true

module Api
  module V1
    class BunchesController < ApplicationController

      # GET /groups/:group_id/bunches
      def index
        group = Group.find_by(id: params[:group_id])

        if !group || !group.belongs_to(@current_user)
          render json: {error: "No such group with id <#{params[:group_id]}>"}, status: :bad_request
          return
        end

        bunches = group.bunches
        render json: bunches.as_json
      end

      def create
        group = Group.find_by(id: params[:group_id])

        if group_exists(group, @current_user)
          result = ::Bunch::Create.call(create_params, group)
          return render json: { errors: result.errors }, status: :bad_request if result.errors.any?

          render json: { response: result.bunch.as_json }, status: :ok
        end
      end

      private

      def create_params
        params.permit(%i[name description])
      end

      def group_exists(group, user)
        if group && group.belongs_to(user)
          return true
        end

        render json: { error: "No such group with id <#{params[:group_id]}>" }, status: :bad_request
        false
      end

    end
  end
end
