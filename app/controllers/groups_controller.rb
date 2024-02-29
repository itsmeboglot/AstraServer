class GroupsController < ApplicationController
  before_action :authenticate_request
  def add #:name, :description
    group = Group.new
    group.name = params[:name]
    group.description = params[:description]
    group.user = @current_user

    if group.save
      render json: { group: group }, status: :ok
    else
      render json: { error: 'Problem with saving new group' }, status: :internal_server_error
    end
  end

  def remove #:id
    group = Group.find_by(id: params[:id])

    if group && group.is_mine(@current_user)
      if group.destroy
        render status: :ok
      else
        render json: { error: 'Problem with deleting group' }, status: :internal_server_error
      end
    else
      render json: { error: "Group with id <#{params[:id]}> does not exist" }, status: :unprocessable_entity
    end
  end

  def update #:id, :name, :description
    group = Group.find(params[:id])

    if group && group.is_mine(@current_user)
      if group.update(name: params[:name], description: params[:description])
        render json: group.as_json(except: [:user_id, :created_at, :updated_at]), status: :ok
      else
        render json: {error: 'Group update failed'}, status: :unprocessable_entity
      end
    else
      render json: {error: "No such group with id <#{params[:id]}>"}, status: :unprocessable_entity
    end
  end

  def get_groups
    @groups = @current_user.groups
    render json: @groups.as_json(except: [:user_id, :created_at, :updated_at])
  end
end
