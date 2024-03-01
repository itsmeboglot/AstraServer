# frozen_string_literal: true
class Card
  class Create < Base

    attr_reader :card

    def self.call(params, group)
      new(params, group).call
    end

    def call
      ActiveRecord::Base.transaction do
        prepare_card
        set_attributes
        group.save

        collect_errors(group)
      end

      self
    end

    private

    attr_reader :word, :definition, :example, :group

    def initialize(params, group)
      @word = params[:word]
      @description = params[:definition]
      @example = params[:example]
      @group = group

      super()
    end

    def prepare_card
      @card = Card.new
    end

    def set_attributes
      card.word = word
      card.definition = definition
      card.example = example
      card.group = group
    end

  end
end
