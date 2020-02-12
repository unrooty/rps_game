# frozen_string_literal: true

module CurbRps
  class Result
    attr_reader :throw

    def initialize(response)
      @json_response = response.parse(:json)
      @throw = @json_response[:body]
    end

    def success?
      !@json_response["errorMessage"] && @json_response["code"] == 200
    end

    def valid?
      @throw.in?(RockPaperScissorsService::BETS)
    end
  end
end
