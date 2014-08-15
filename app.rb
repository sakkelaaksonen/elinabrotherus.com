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
  #need to do multiroutes here?
  get '/' do
    #redirect to news?
  end

  #news
  get '/news' do
    mustache :news
  end
 
 #photography
  get '/photography' do
    mustache :photography
  end
 
  #Editions
  get '/editions' do
    mustache :editions
  end


  #Videos
  get '/videos' do
    mustache :videos
  end
  
  #Exhibitions
  get '/exhibitions' do
    mustache :exhibitions
  end

  #Bibliography
  get '/bibiliography' do
    mustache :bibiliography
  end
  
  #Links
  get '/link' do
    mustache :links
  end

  #Contact
  get '/contact' do
    mustache :contact
  end

  get '/guestbook' do
    mustache :guestbook
  end
  
  #Guestbook

  # get '/nolayout' do
  #   content_type 'text/plain'
  #   mustache :nolayout, :layout => false
  # end
end
