class App
  module Views
    class PhotoGallery < Layout
      def pics
        @pics || @gallery['pics']
      end

      def url 
        @gallery['url']
      end

    end
  end
end