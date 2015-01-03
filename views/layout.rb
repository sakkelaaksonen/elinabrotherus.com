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
        if @menu_items.nil? 
            @menu_items = App.settings.menus.dup
        end
        @menu_items.each do |section|
          section['items'].each do |page|
            puts page['id']
            puts @current_page['id']
            puts  page['id'] == @current_page['id']
            puts "=NEXT=\n"
            if page['id'] == @current_page['id']
              page['active'] = 'active'
            else 
              page['active'] = ''
            end
          end
        end
        return @menu_items
        
      end

      def gacode
        App.settings.gacode
      end

      #EOC
    end
  end
end
