require 'sinatra/base'
require 'mustache/sinatra'

class App < Sinatra::Base
  register Mustache::Sinatra
  require './views/layout.rb'
  require './views/index.rb'
  require './views/other.rb'
  

  set :mustache, {
    :views     => 'views',
    :templates => 'templates'
  }

  # home
  get '/' do
    @title = "Mustache + Sinatra = Wonder"
    mustache :index
  end

  #news
  get '/other' do
    mustache :other
  end

  #photography

  #Editions

  #Videos

  #Exhibitions

  #Bibliography

  #Links

  #Contract

  #Guestbook

  # get '/nolayout' do
  #   content_type 'text/plain'
  #   mustache :nolayout, :layout => false
  # end
end
