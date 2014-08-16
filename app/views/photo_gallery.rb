class App
  module Views
    class PhotoGallery < Layout
      def gallery_pics
        @pics      
      end

      def gallery_list
        @galleries.map do |g|
        
          {
            active_class: '',
            name: g['name'],
            year: g['year'],
            url: 'foo.jpg'
          }
        
          
        end
      end
    end
  end
end