class App
  module Views
    class PhotoGallery < Layout
      def pics
        @pics || @gallery['pics']
      end

      def url 
        @gallery['url']
      end


      def title
        @gallery['name'] rescue @current_page['title']
      end
    end
  end
end