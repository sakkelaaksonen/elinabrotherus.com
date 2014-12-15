class App
  module Views
    class PhotoGallery < Layout
      def pics
        @pics || @gallery['pics']
      end

    end
  end
end