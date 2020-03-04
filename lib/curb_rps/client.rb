# frozen_string_literal: true

module CurbRps
  class Client
    API_URL = "https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw"
    TIMEOUT = 3

    def load_throw
      response = HTTP.timeout(connect: TIMEOUT, read: TIMEOUT).get(API_URL)

      CurbRps::Result.new(response)
    end
  end
end
