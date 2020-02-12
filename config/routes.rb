# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :rock_paper_scissors, only: %i[index]
  post "play", to: "rock_paper_scissors#play"
  root "rock_paper_scissors#index"
end
