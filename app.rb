require 'sinatra'
require 'sinatra/reloader' if development?
require './helpers/cookies.rb'
require './helpers/blackjack.rb'

helpers Cookies


get '/' do
  erb :index
end