# frozen_string_literal: true

class RockPaperScissorsController < ApplicationController
  BETS = %w[rock paper scissors].freeze

  def index
    @context[:bets] = RockPaperScissorsService::BETS
  end

  def play
    game_service = RockPaperScissorsService.new(params[:bet])

    @context[:result] = game_service.play_game.result
    @context[:computer_choice] = game_service.computer_choice
    @context[:human_choice] = game_service.human_choice

    render "game_result.js.erb"
  end
end
