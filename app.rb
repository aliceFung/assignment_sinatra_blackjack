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
  # sleep (2)
  # redirect to '/blackjack'

end

get '/blackjack' do
  instance = nil
  if params[:input] == "new"
    instance = Blackjack.new
  else
    instance = Blackjack.new(load_game)
  end
  # @money = bankroll
  # unless load_game
  #   @money -= 10
  # end

  # set_bankroll(@money)


  @output = instance.render
  save_game(instance.game)

  erb :blackjack
end

post '/blackjack' do
  # @money = bankroll
  instance = Blackjack.new(load_game)
  if params[:input] == "hit"
      instance.hit
  end
  save_game(instance.game)

  if params[:input] == "stay"
    redirect to('/blackjack/dealer')
  else
    redirect to('/blackjack')
  end
end

get '/blackjack/dealer' do
  instance = Blackjack.new(load_game)
  instance.dealer_move
  save_game(instance.game)
  if instance.bust?
    redirect to("/result/loss")
  elsif instance.win?
    redirect to("/result/win")
  else
    redirect to("/result/loss")
  end
  # if instance.win?
  #   redirect to("/result/win")
  # else
  #   redirect to("/result/loss")
  # end
end

get '/result/win' do
  instance = Blackjack.new(load_game)
  @output = instance.render
  cookies.delete("game_state")
  response.delete_cookie("game_state")
  response.set_cookie("game_state", "")
  erb :win
  #binding.pry
  # @money = bankroll
  # @money += 20
  # set_bankroll(@money)
end

get '/result/loss' do
  instance = Blackjack.new(load_game)
  @output = instance.render
  cookies.delete("game_state")
  response.delete_cookie("game_state")
  response.set_cookie("game_state", "")
  erb :loss
  #binding.pry
end