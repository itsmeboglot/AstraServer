# frozen_string_literal: true

module Api
  module V1
    class BunchesController < ApplicationController

      before_action :set_group
      before_action :set_bunch, only: [:delete]

      # GET /groups/:group_id/bunches
      def index
        if @group.present?
          bunches = @group.bunches
          render json: bunches.as_json
        end
      end

      def create
        if @group.present?
          result = ::Bunch::Create.call(create_params, group)
          return render json: { errors: result.errors }, status: :bad_request if result.errors.any?

          render json: { response: result.bunch.as_json }, status: :ok
        end
      end

      def update

      end

      def delete
        if @bunch.present?
          if group.destroy
            render status: :ok
          else
            render json: { error: 'Problem with deleting group' }, status: :internal_server_error
          end
        end
      end

      private

      def set_group
        @group = Group.find_by(id: params[:group_id])

        unless group_exists?(@group, @current_user)
          @group = nil
        end
      end

      def set_bunch
        @bunch = @group.present? ? @group.bunches.find_by(id: params[:id]) : nil
      end

      def create_params
        params.permit(%i[name description])
      end

      def group_exists?(group, user)
        if group && group.belongs_to?(user)
          return true
        end

        render json: { error: "No such group with id <#{params[:group_id]}>" }, status: :bad_request
        false
      end

    end
  end
end
