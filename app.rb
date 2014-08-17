%W(
  sinatra/base
  sinatra/config_file
  mustache/sinatra
  sinatra/assetpack
  json
  nokogiri
  sinatra/sequel
).each { |pack| require pack }

class App < Sinatra::Base

  register Mustache::Sinatra
  register Sinatra::AssetPack
  # register Sinatra::Sequel
  register Sinatra::ConfigFile

  config_file("#{settings.root}/config.yml")

  #
  # stuff inside this block is set only at startup
  #
  configure do
    # set( :database, 'sqlite://elinabrotherus.db')
    #Sequel sqlite3 / pq database for images
    set( :root, File.dirname(__FILE__) )

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


    #Asset pipeline settings
    assets {

      serve '/js',     from: './js'        # Default
      serve '/css',    from: './css'       # Default
      serve '/images', from: './images'    # Default

      # The second parameter defines where the compressed version will be served.
      # (Note: that parameter is optional, AssetPack will figure it out.)
      # js :app, '/js/app.js', [
      #   '/js/vendor/**/*.js',
      #   '/js/lib/**/*.js'
      # ]

      js :app, [
        '/js/*.js',
        '/js/**/*.js',
      ]

      css :application, './css/app.css', [
        # './css/main.less',
        '/css/styles.css'
      ]
      #use default compressions
    }



  end



  # must set app root for asset pack

  ##

  # Helpers
  helpers( Sinatra::ConfigFile )

  helpers do


# galleryxml = Nokogiri::XML::parse(File.read('xml/gallery.xml'))
    # galleryhash =  galleryxml.xpath('//gallery').map do |node|
    #   {
    #     # childen: node.xpath('folder').text
    #     id: node.attr('id'),
    #     url: node.xpath('folder').text,
    #     name: node.xpath('name').text,
    #     pics: node.xpath('pic').each_with_index.map {|pic,i| {
    #       id: i, 
    #       src: "#{node.xpath('folder').text}/#{pic.xpath('lores').text}.jpg",
    #       title: pic.xpath('title').text
    #     }}

    #   }   
    #  end
    #  galleryhash.to_json

    #  newjson = JSON.parse(File.read('newfiles.json'))
    #  newjson['galleries'].concat(galleryhash)
    #  File.open('allgalleries.json','w') {|f| f.write(newjson.to_json)}

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

  end






  # get '/set/' do
  #   # @img =
  #   Image.create({
  #     title: params[:title],
  #     dimensions: params[:dimensions],
  #     url: params[:url], #todo. make this from model
  #     edition: params[:edition],
  #    })
  # end

  # get '/get/:name' do
  #  Image.by_title( :name).to_s
  # end

  # home

  get '/' do
    
     # content_type :json
     "/photos/#{get_gallery('the-new-painting')['pics'].first['src']}"
    # ENV.inspect

    # redirect to('/news')
  end
  # #news
  #  get %r{\/news\/?$} do

  #    set_page('news')
  #    mustache :news
  #  end

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
    @galleries = JSON.parse(File.read('newfiles.json'))['galleries']
    @gallery = @galleries.find { |g|  g['front'] == @gallerytoken}

    p @galleries.first

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

  # static entries for ajax
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
    # @entry_number= params['entry']

    # params.to_s
  end

  get %r{\/guestbook\/?$} do
    set_page('guestbook')
    mustache :guestbook
  end


end
