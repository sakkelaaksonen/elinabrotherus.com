class App
  module Views
    class PhotoGallery < Layout
      def pics
        @pics
      end

      def gallery_list
        @galleries.map do |g|
          {
            active_class: '',
            name: g['name'],
            year: g['year'],
            url: g['url']
          }
        end
      end
    end
  end
end