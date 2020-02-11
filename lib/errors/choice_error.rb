# frozen_string_literal: true

module Errors
  class ChoiceError < StandardError
    def initialize(message)
      super(message)
    end
  end
end
