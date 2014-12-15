class App
  module Views
    class PhotographyIndex < PhotoGallery
      # @gallerytoken = 'front'
       
      def gallery_list
        @galleries.map do |g|
          {
            active_class: '',
            name: g['name'],
            year: g['year'],
            url: g['url'],
            cover: "#{g['url']}/#{g['pics'].first['id']}.jpg"
          }
        end
      end
    end
  end
end