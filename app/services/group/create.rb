# frozen_string_literal: true
class Group
  class Create < Base

    attr_reader :group

    def self.call(params, user)
      new(params, user).call
    end

    def call
      ActiveRecord::Base.transaction do
        prepare_group
        set_attributes
        group.save

        collect_errors(group)
      end

      self
    end

    private

    attr_reader :name, :description, :user

    def initialize(params, user)
      @name = params[:name]
      @description = params[:description]
      @user = user

      super()
    end

    def prepare_group
      @group = Group.new
    end

    def set_attributes
      group.name = name
      group.description = description
      group.user = user
    end

  end
end
