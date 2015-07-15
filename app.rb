require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'json'
require './helpers/cookies.rb'
require './helpers/blackjack.rb'

helpers Cookies


get '/' do
  erb :index
end

get '/blackjack' do
  instance = Blackjack.new(load_game)
  redirect to("/result/win") if instance.win?
  redirect to("/result/loss") if instance.bust?
  @output = instance.render
  save_game(instance.game)
  # binding.pry
  erb :blackjack
  # binding.pry
  
end

post '/blackjack' do
  instance = Blackjack.new(load_game)
  instance.hit if params[:input] == "hit"
  save_game(instance.game)#save cookie
  # binding.pry
  redirect to ('/blackjack')
end


get 'result/win' do
  erb :win
end