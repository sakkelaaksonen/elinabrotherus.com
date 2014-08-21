 # # Mustache settings
 #    set( :mustache, {
 #           :views     => 'views',
 #           :templates => 'templates'
 #    })


 #    #Asset pipeline settings
 #    assets {

 #      serve '/js',     from: './js'        # Default
 #      serve '/css',    from: './css'       # Default
 #      serve '/images', from: './images'    # Default

 #      # The second parameter defines where the compressed version will be served.
 #      # (Note: that parameter is optional, AssetPack will figure it out.)
 #      # js :app, '/js/app.js', [
 #      #   '/js/vendor/**/*.js',
 #      #   '/js/lib/**/*.js'
 #      # ]

 #      js :app, [
 #        '/js/*.js',
 #        '/js/**/*.js',
 #      ]

 #      css :application, './css/app.css', [
 #        # './css/main.less',
 #        '/css/styles.css'
 #      ]
 #      #use default compressions
 #    }
