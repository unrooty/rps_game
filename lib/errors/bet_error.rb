# frozen_string_literal: true

module Errors
  class BetError < StandardError
    def initialize(message)
      super(message)
    end
  end
end
