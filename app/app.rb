require 'sinatra/base'
require 'mustache/sinatra'
require 'sinatra/assetpack'
# require 'less'

class App < Sinatra::Base
  register Mustache::Sinatra
  register Sinatra::AssetPack 
  
  helpers do

  end  

  require './views/layout.rb'
  require './views/index.rb'
  require './views/other.rb'
  require './views/news.rb'

  # must set app root for asset pack
  set :root, File.dirname(__FILE__) 

  set :mustache, {
    :views     => 'views',
    :templates => 'templates'
  }
  
  assets {
    
    serve '/js',     from: './js'        # Default
    serve '/css',    from: './css'       # Default
    serve '/images', from: './images'    # Default

    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    js :app, '/js/app.js', [
      '/js/vendor/**/*.js',
      '/js/lib/**/*.js'
    ]

    css :application, './css/styles.css', [
      './css/css.less'
    ]
    #use default compressions
    }
  # home

  
 #news
  get '/' do 
    redirect to('/news')
  end
  
  get %r{\/news\/?} do
    mustache :news
  end
 
 #photography
  get %r{\/photography\/?} do
    mustache :photography
  end
 
  #Editions
  get %r{\/editions\/?} do
    mustache :editions
  end


  #Videos
  get %r{\/videos\/?} do
    mustache :videos
  end
  
  #Exhibitions
  get %r{\/exhibitions\/?} do
    mustache :exhibitions
  end

  #Bibliography
  get %r{\/bibliography\/?} do
    mustache :bibiliography
  end
  
  #Links
  get %r{\/links\/?} do
    mustache :links
  end

  #Contact
  get %r{\/contact\/?} do
    mustache :contact
  end

  #Guestbook
  get %r{\/guestbook\/?} do
    mustache :guestbook
  end
  
  
  # get '/nolayout' do
  #   content_type 'text/plain'
  #   mustache :nolayout, :layout => false
  # end
end
