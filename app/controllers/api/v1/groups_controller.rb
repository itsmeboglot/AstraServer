# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController

      def index
        groups = current_user.groups

        render json: groups.as_json(except: [:user_id, :created_at, :updated_at])
      end

      def create
        result = ::Group::Create.call(create_params, current_user)
        return render json: { errors: result.errors }, status: :bad_request if result.errors.any?

        render json: { response: result.group.as_json }, status: :ok
      end

      def delete #:id
        group = Group.find_by(id: params[:id])

        if group && group.belongs_to?(@current_user)
          if group.destroy
            render status: :ok
          else
            render json: { error: 'Problem with deleting group' }, status: :internal_server_error
          end
        else
          render json: { error: "Group with id <#{params[:id]}> does not exist" }, status: :bad_request
        end
      end

      def update #:id, :name, :description
        group = Group.find_by(id: params[:id])

        if group && group.belongs_to?(@current_user)
          if group.update(update_params)
            render json: group.as_json, status: :ok
          else
            render json: {error: 'Group update failed'}, status: :unprocessable_entity
          end
        else
          render json: {error: "No such group with id <#{params[:id]}>"}, status: :bad_request
        end
      end

      private

      def create_params
        params.permit(%i[name description])
      end

      def update_params
        params.permit(%i[name description])
      end

    end
  end
end
