class App
  module Views

    class Layout < Mustache


      def css
        @css
      end

      def js
        @js
      end

      def page_class
        @page_class
      end

      def title
        @current_page['title']
      end

      def meta_keywords
        @current_page['keywords'] || ''
      end

      def meta_desc
        @current_page['desc'] || ''
      end

      def menu
        #App.settings.menus.map
        return App.settings.menus.each do |section|
          section['items'].each do |page|
            if page['name'] == @current_page['title']
              page['active'] = 'active'
            end
          end
        end
      end

      def gacode
        App.settings.gacode
      end

      #EOC
    end
  end
end
