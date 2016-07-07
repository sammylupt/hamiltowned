Rails.application.routes.draw do

  root "messages#new"
  post "/", to: "messages#create", as: :messages
  get "/messages/:id", to: "messages#show", as: :message

  get "/lottery_ticket_redemption/:id", to: "messages#crying_jordan", as: :crying_jordan
  get "/testing", to: "messages#send_test_email"
end
