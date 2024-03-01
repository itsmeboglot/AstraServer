# frozen_string_literal: true

class Bunch
  class Create < Base

    attr_reader :bunch

    def self.call(params, group)
      new(params, group).call
    end

    def call
      ActiveRecord::Base.transaction do
        prepare_bunch
        set_attributes
        bunch.save

        collect_errors(bunch)
      end

      self
    end

    private

    attr_reader :name, :description, :group

    def initialize(params, group)
      @name = params[:name]
      @description = params[:description]
      @group = group

      super()
    end

    def prepare_bunch
      @bunch = Bunch.new
    end

    def set_attributes
      bunch.name = name
      bunch.description = description
      bunch.group = group
    end

  end
end
