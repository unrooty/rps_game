# frozen_string_literal: true

require "rails_helper"

RSpec.describe RockPaperScissorsService do
  include_context "stub_curb"

  let(:rock_stub) do
    stub_request(:get, CurbRps::Client::API_URL).to_return(
      status: 200, body: '{"code":200, "body": "rock"}',
      headers: { "content-type" => "application/json; charset=utf-8" }
    )
  end

  let(:paper_stub) do
    stub_request(:get, CurbRps::Client::API_URL).to_return(
      status: 200, body: '{"code":200, "body": "paper"}',
      headers: { "content-type" => "application/json; charset=utf-8" }
    )
  end

  let(:scissors_stub) do
    stub_request(:get, CurbRps::Client::API_URL).to_return(
      status: 200, body: '{"code":200, "body": "scissors"}',
      headers: { "content-type" => "application/json; charset=utf-8" }
    )
  end

  context "with rock as human choice" do
    let(:service) { described_class.new("rock") }

    it "works and returns `tie` result for CURB rock" do
      rock_stub

      service.play_game

      expect(service.result).to eq("tie")
    end

    it "works and returns `computer` result for CURB paper" do
      paper_stub

      service.play_game

      expect(service.result).to eq("computer")
    end

    it "works and returns `human` result for CURB scissors" do
      scissors_stub

      service.play_game

      expect(service.result).to eq("human")
    end
  end

  context "with paper as human choice" do
    let(:service) { described_class.new("paper") }

    it "works and returns `human` result for CURB rock" do
      rock_stub

      service.play_game

      expect(service.result).to eq("human")
    end

    it "works and returns `tie` result for CURB paper" do
      paper_stub

      service.play_game

      expect(service.result).to eq("tie")
    end

    it "works and returns `computer` result for CURB scissors" do
      scissors_stub

      service.play_game

      expect(service.result).to eq("computer")
    end
  end

  context "with scissors as human choice" do
    let(:service) { described_class.new("scissors") }

    it "works and returns `computer` result for CURB rock" do
      rock_stub

      service.play_game

      expect(service.result).to eq("computer")
    end

    it "works and returns `human` result for CURB paper" do
      paper_stub

      service.play_game

      expect(service.result).to eq("human")
    end

    it "works and returns `tie` result for CURB scissors" do
      scissors_stub

      service.play_game

      expect(service.result).to eq("tie")
    end
  end

  it "raises error for illegal human bet" do
    expect { described_class.new("rok") }.to(
      raise_error(Errors::BetError, "Illegal bet `rok` was provided!")
    )
  end

  it "throws own bet if CURB response failure" do
    stub_request(:get, CurbRps::Client::API_URL).to_return(
      status: 200, body: '{"code":500, "body": "Something went wrong!"}',
      headers: { "content-type" => "application/json; charset=utf-8" }
    )

    service = described_class.new("rock")

    service.play_game

    expect(service.computer_choice).to be_in(%w[rock paper scissors])
  end

  it "throws own bet if CURB response invalid" do
    stub_request(:get, CurbRps::Client::API_URL).to_return(
      status: 200, body: '{"code":200, "body": "banana"}',
      headers: { "content-type" => "application/json; charset=utf-8" }
    )

    service = described_class.new("rock")

    service.play_game

    expect(service.computer_choice).to be_in(%w[rock paper scissors])
  end

  it "throws own bet if CURB request timeout" do
    stub_request(:get, CurbRps::Client::API_URL).to_timeout

    service = described_class.new("rock")

    service.play_game

    expect(service.computer_choice).to be_in(%w[rock paper scissors])
  end
end
