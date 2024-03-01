# frozen_string_literal: true

class Card
  class Create < Base

    attr_reader :card

    def self.call(params, bunch)
      new(params, bunch).call
    end

    def call
      ActiveRecord::Base.transaction do
        prepare_card
        set_attributes
        card.save

        collect_errors(card)
      end

      self
    end

    private

    attr_reader :word, :definition, :example, :bunch

    def initialize(params, bunch)
      @word = params[:word]
      @description = params[:definition]
      @example = params[:example]
      @bunch = bunch

      super()
    end

    def prepare_card
      @card = Card.new
    end

    def set_attributes
      card.word = word
      card.definition = definition
      card.example = example
      card.bunch = bunch
    end

  end
end
