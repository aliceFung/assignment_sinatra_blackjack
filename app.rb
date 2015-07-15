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
  binding.pry
  instance = Blackjack.new(load_game)
  redirect to("/result/win") if instance.win?
  redirect to("/result/loss") if instance.bust?
  @output = instance.render
  erb :blackjack
  #if hit, set cookie["hit"] = true
end

post '/blackjack/hit' do
  binding.pry
  instance = Blackjack.new(load_game)
  instance.hit
  # game logic
  save_game(instance.game)#save cookie
  redirect to ('/blackjack')
end


get 'result/win' do
  erb :win
end