# frozen_string_literal: true

class RockPaperScissorsController < ApplicationController
  def index
    @context[:bets] = RockPaperScissorsService::BETS
  end

  def play
    game_service = RockPaperScissorsService.new(params[:bet])

    game_service.play_game

    @context[:result] = game_service.result
    @context[:computer_choice] = game_service.computer_choice
    @context[:human_choice] = game_service.human_choice

    render "result.js.erb"
  end
end
