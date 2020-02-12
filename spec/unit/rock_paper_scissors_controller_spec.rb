# frozen_string_literal: true

require "rails_helper"

RSpec.describe RockPaperScissorsController, type: :controller do
  include_context "stub_curb"

  describe "Get index" do
    it "has a 200 status code" do
      get :index, params: {}
      expect(response.status).to eq(200)
    end
  end

  describe "Post play" do
    let(:curb_stub) do
      stub_request(:get, CurbRps::Client::API_URL).to_return(
        status: 200, body: '{"code":200, "body": "rock"}',
        headers: { "content-type" => "application/json; charset=utf-8" }
      )
    end

    it "has a status 200 code with js format and params" do
      post :play, params: { bet: "rock" }, format: :js
      expect(response.content_type).to eq "text/javascript; charset=utf-8"
      expect(response.status).to eq(200)
    end

    it "has a status 200 code with json format and params" do
      post :play, params: { bet: "rock" }, format: :json
      expect(response.content_type).to eq "application/json; charset=utf-8"
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).keys).to match_array(%w[computer_choice human_choice result])
    end

    it "has a status 400 code with json format and invalid params" do
      post :play, params: { bet: "rok" }, format: :json
      expect(response.content_type).to eq "application/json; charset=utf-8"
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body).keys).to match_array(%w[error_message])
    end

    it "has a status 400 code with json format and invalid params" do
      post :play, params: { bet: "rok" }, format: :js
      expect(response.content_type).to eq "text/javascript; charset=utf-8"
      expect(response.status).to eq(200)
    end
  end
end
