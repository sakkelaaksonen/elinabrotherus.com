%W(
  sinatra/base
  sinatra/config_file
  mustache/sinatra
  sinatra/assetpack
  json
  nokogiri
  sass
  crack
).each { |pack| require pack }

class App < Sinatra::Base
  register Mustache::Sinatra
  register Sinatra::AssetPack
  # register Sinatra::Sequel
  register Sinatra::ConfigFile
  config_file("#{settings.root}/config.yml")

  set( :root, File.dirname(__FILE__) )
  #Asset pipeline settings
  assets {


    serve '/javascripts', from: 'public/javascripts'
    serve '/stylesheets', from: 'public/stylesheets'
    
    # serve '/js',     from: './app/js'        # Default
    # serve '/css',    from: './app//css'       # Default
    # serve '/images', from: './app/images'    # Default
    # The second parameter defines where the compressed version will be served.
    # (Note: that parameter is optional, AssetPack will figure it out.)
    # js :app, '/js/app.js', [
    #   '/js/vendor/**/*.js',
    #   '/js/lib/**/*.js'
    # ]
    js :loader, 'load.js', [
      # "/js/jquery.cookie.js", 
      # "/js/jquery.scrollTo-1.4.2-min.js", 
      # # "/js/jquery.viewport.mini.js",
      # "/js/jquery.form.js",
      # "/js/brotherus.guestbook.js"


      # "/js/brotherus.functions.js",
      # "/js/brotherus.main.js",
      # "/js/brotherus.guestbook.js",
      # "/js/supersleight-min.js"
    ]
    css :all, './css/all.css', [
      # './css/main.less',
      '/css/eb.css'
    ]
    #use default compressions
  }
  #
  # stuff inside this block is set only at startup
  #
  configure do
    # set( :database, 'sqlite://elinabrotherus.db')
    #Sequel sqlite3 / pq database for images
    #db Migrations
    # database.migration "create images" do
    #   database.create_table :images do
    #     primary_key :id
    #     text        :title
    #     text        :url
    #     text        :edition
    #     text        :year
    #     text        :dimensions
    #     # timestamp   :bizzle, :null => false
    #     index :url, :unique => true
    #     # index :title, :url => true
    #   end
    # end
    # database.migration "create galleries" do
    #   database.create_table :galleries do
    #     primary_key :id
    #     text        :name
    #     text        :url
    #     index :url, :unique => true
    #   end
    # end
    # #DB classes
    # class Gallery < Sequel::Model
    #   one_to_many :images, eager: [:images]
    # end
    # class Image < Sequel::Model
    #    many_to_one :gallery
    # end
    # Load models
    # Dir.glob("#{settings.root}/models/*.rb") { |file| require file }
    ##
    # Views
    #view super classes
    require "#{settings.root}/views/layout"
    require "#{settings.root}/views/photo_gallery"
    #then the rest in no particular order
    Dir.glob("./views/*.rb") { |file| require file }
    # Mustache settings
    set( :mustache, {
           :views     => 'views',
           :templates => 'templates'
    })

  end
  # must set app root for asset pack
  ##
  # Helpers
  helpers( Sinatra::ConfigFile )
  helpers do

    def set_page (name)
      @current_page = settings.pages[name]
      @page_class = name
    end

    def load_galleries
      @galleries ||=  JSON.parse(File.read( 'allgalleries.json'))['galleries']
    end

    def get_gallery(with_id)
      load_galleries.find {|g| g['id'] == with_id}
    end

    def compiled_assets
      @assets ||= {
        css: css( :all, :media => 'screen' ),
        js: js( :all )
       }
    end
  end

# set asset manager erb output 
# to mustache's scope via instance method inheritance
  before  do
    @css = compiled_assets[:css]
    @js = compiled_assets[:js]
  end
  
  get '/' do
    #compiled_assets[:js]

    redirect to( '/news')
    # set_page('news')
    # mustache :news
  end

  #news
  get %r{/news/?$} do
    set_page('news')
    mustache :news
  end
  #photography
  get '/photography/:gallery' do
    # @galleries - collection of all galleries
    # todo: memcache this whole output html with before & after filters?
    set_page('photography')

    @gallerytoken = params[:gallery]

    @galleries = load_galleries
    @gallery = get_gallery(@gallerytoken)
    @pics = @gallery['pics']
    mustache :photography
  end
  #photo main
  get %r{/photography/?$} do
    set_page('photography')
    @galleries = load_galleries
    
    # @list = @galleries.map {|g| g[cover[:pics].first}
    # @gallery = get_gallery('what-if')
    # @pics = @gallery['pics']
    # @pics.to_json
    mustache :photography_index
  end
  #
  # Static pages:
  # Could do this with filters as well but
  # This meta solutions seems more maintainable and far more DRY
  #
  %W(
    news
    editions
    videos
    exhibitions
    bibliography
    links
    contact
  ).each do |pagetoken|
    get %r{/#{pagetoken}/?$} do
      set_page(pagetoken)
      mustache( pagetoken.to_sym)
    end
  end
  #####
  # Guestbook
  #####
  #


  get '/guestbook/entries.json' do
    # content_type :xml
    
    content_type :json
    Crack::XML.parse(File.read('xml/guestbook.xml')).to_json;
    # File.read('json/guestbook.json');
  end

  # static entries for ajax
  get '/guestbook/entries.xml' do
    content_type :xml
    File.read('xml/guestbook.xml');
  end
  post %r{/guestbook/save/?$} do
    @entry_name= params['entryName']
    @entry_message= params['entryMessage']
    params.to_s
  end
  post %r{/guestbook/delete/?$} do
    'no way dude'
    # @entry_number= params['entry']
    # params.to_s
  end
  get %r{/guestbook/?$} do
    set_page('guestbook')
    mustache :guestbook
  end
end
