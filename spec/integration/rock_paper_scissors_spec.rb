# frozen_string_literal: true

require "rails_helper"

RSpec.describe RockPaperScissorsService do
  let(:service) { described_class.new("rock") }

  it "works with CURB API" do
    service.play_game

    expect(service.result).to be_in(%w[tie computer human])
  end
end
