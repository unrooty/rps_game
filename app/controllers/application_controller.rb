# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :initialize_context
  protect_from_forgery unless: -> { request.format.json? }

  def initialize_context
    @context = {}
  end
end
