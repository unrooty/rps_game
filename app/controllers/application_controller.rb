# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :initialize_context

  def initialize_context
    @context = {}
  end
end
