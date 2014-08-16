require 'sinatra/base'
require "sinatra/config_file"
require 'mustache/sinatra'
require 'sinatra/assetpack'
require 'json'

class App < Sinatra::Base
  
  register Mustache::Sinatra
  register Sinatra::AssetPack 
  register Sinatra::ConfigFile
  
  # must set app root for asset pack
  set( :root, File.dirname(__FILE__) )
  
  #first layout
  require './views/layout'
  #then the rest in no particular order
  Dir.glob("./views/*.rb") { |file| require file }
  
  

  helpers( Sinatra::ConfigFile)
  helpers do
    def set_page (name)
      @current_page = settings.pages[name]
      @page_class = name
    end
  end
  
  
  config_file( "#{settings.root}/config.yml")

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


  before do
  

  end

  
 #news

  get '/menu' do
    
  end

  get '/' do 
    redirect to('/news')
  end
  
  get %r{\/news\/?$} do

    set_page('news')
    mustache :news
  end
 
 #photography
  
  # get %{\/photography\/:gallery} do
    
  # # @galleries - collection of all galleries
  # # todo: memcache this whole output html with before & after filters?
  #   set_page('photography')
  #   @gallerytoken = params[:gallery] 
  #   @galleries = JSON.parse(File.read('newfiles.json'))['galleries']
  #   @gallery = @galleries.find { |g|  g['id'] == @gallerytoken}
  #   @pics = @gallery['pics']
    
  #   mustache :photography
  # end
  #photo main
  get %r{\/photography\/?$} do
    set_page('photography')      
    mustache :photography_index
  end


  
  #Editions
  get %r{\/editions\/?$} do
    set_page('editions')
    mustache :editions
  end


  #Videos
  get %r{\/videos\/?$} do
    set_page('videos')
    mustache :videos
  end
  
  #Exhibitions
  get %r{\/exhibitions\/?$} do
    set_page('exhibitions')
    mustache :exhibitions
  end

  #Bibliography
  get %r{\/bibliography\/?$} do
    set_page('bibliography')
    mustache :bibliography
  end
  
  #Links
  get %r{\/links\/?$} do
    set_page('links')
    mustache :links
  end

  #Contact
  get %r{\/contact\/?$} do
    set_page('contact')
    mustache :contact
  end

  #Guestbook
  
  #static entries for ajax
  get '/guestbook/entries.xml' do
    content_type :xml
    File.read('xml/guestbook.xml')
  end  

  post %r{\/guestbook\/save\/?$} do
    @entry_name= params['entryName']
    @entry_message= params['entryMessage']
    params.to_s
  end

  post %r{\/guestbook\/delete\/?$} do
   'no way dude' 
    @entry_number= params['entry']
    
    params.to_s
  end

  get %r{\/guestbook\/?$} do
    set_page('guestbook')
    mustache :guestbook
  end


  
  #gallery from JSON
  
end
