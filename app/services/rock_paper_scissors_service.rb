# frozen_string_literal: true

class RockPaperScissorsService
  BETS = %w[rock paper scissors].freeze
  REVERSED_BETS = BETS.reverse
  RESULTS = [
    TIE = "tie",
    COMPUTER = "computer",
    HUMAN = "human",
  ].freeze

  attr_reader :human_choice
  attr_reader :computer_choice
  attr_reader :result

  def initialize(human_choice)
    @human_choice = human_choice.downcase

    validate_choice(@human_choice)
  end

  def play_game
    @computer_choice = build_computer_choice

    @result = build_result

    self
  end

  private

  def build_result(human_choice: @human_choice, computer_choice: @computer_choice)
    index = REVERSED_BETS.index(@human_choice)
    winning_choice = REVERSED_BETS[index - 1]

    case computer_choice
    when human_choice
      TIE
    when winning_choice
      COMPUTER
    else
      HUMAN
    end
  end

  def validate_choice(choice)
    return if BETS.include?(choice)

    raise Errors::BetError, "Illegal bet `#{choice}` was provided!"
  end

  def build_computer_choice(client = CurbRps::Client.new)
    response = client.load_throw

    return response.throw.downcase if response.success? && response.valid?

    BETS.sample
  rescue HTTP::TimeoutError
    BETS.sample
  end
end
