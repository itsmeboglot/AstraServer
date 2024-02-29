# frozen_string_literal: true

module Api
  module V1
    class GreetingsController < ApplicationController
      def hello
        render plain: "HELLO PIDARAS BEZROBITNIY! Spectre apruvnuly?"
      end
    end
  end
end
