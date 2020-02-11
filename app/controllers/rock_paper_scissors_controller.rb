# frozen_string_literal: true

class RockPaperScissorsController < ApplicationController
  def index
    @context[:bets] = RockPaperScissorsService::BETS
  end

  def play
    game_service = RockPaperScissorsService.new(params[:bet])

    game_service.play_game

    @context = {
      result: game_service.result,
      computer_choice: game_service.computer_choice,
      human_choice: game_service.human_choice,
    }

    respond_to do |format|
      format.js { render "result.js.erb" }
      format.json do
        render json: @context
      end
    end
  rescue Errors::BetError
    @context[:error_message] = t("illegal_bet", bet: params[:bet])

    respond_to do |format|
      format.js { render "error.js.erb" }
      format.json do
        render json: @context
      end
    end
  end
end
