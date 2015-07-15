require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/cookies'
require 'pry'
require 'json'
require './helpers/cookies.rb'
require './helpers/blackjack.rb'

enable :sessions

helpers Cookies


get '/' do
  erb :index
end

get '/blackjack' do
  @money = bankroll
  instance = Blackjack.new(load_game)
  redirect to("/result/win") if instance.win?
  redirect to("/result/loss") if instance.bust?

  @output = instance.render
  save_game(instance.game)

  erb :blackjack
end

post '/blackjack' do

  instance = Blackjack.new(load_game)
  if params[:input] == "hit"
      instance.hit
      bankroll -= 10
  end
  save_game(instance.game)
  # binding.pry
  redirect to('/blackjack/dealer') if params[:input] == "stay"
  redirect to('/blackjack')
end

get '/blackjack/dealer' do
  instance = Blackjack.new(load_game)
  instance.dealer_move
  save_game(instance.game)
  redirect to("/result/win") if instance.win?
  redirect to("/result/loss")
end

get '/result/win' do
  instance = Blackjack.new(load_game)
  @output = instance.render
  cookies["game_state"] = nil
  # binding.pry
  erb :win
end

get '/result/loss' do
  instance = Blackjack.new(load_game)
  @output = instance.render
  cookies["game_state"] = nil
  # binding.pry
  erb :loss
end