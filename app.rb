require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require './helpers/cookies.rb'
require './helpers/blackjack.rb'

helpers Cookies


get '/' do
  erb :index
end

get '/blackjack' do
  game = Blackjack.new #(cookie)
  redirect to("/result/win") if game.win?
  redirect to("/result/loss") if game.bust?
  @output = @game.render
  erb :blackjack

end

post '/blackjack/hit'
  # game logic
  #save cooke
  redirect to ('/blackjack')


get 'result/win' do
  erb :win
end