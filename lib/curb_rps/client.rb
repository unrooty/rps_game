# frozen_string_literal: true

module CurbRps
  class Client
    def load_throw
      response = HTTP.get("https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw")

      CurbRps::Result.new(response)
    end
  end
end
