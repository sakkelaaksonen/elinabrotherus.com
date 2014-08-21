class App
  module Views
    
    class Layout < Mustache

      def foo
        @foo
      end

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
        @title ||= 'Welcome'
      end

      def meta_keywords
        @current_page['keywords'] || ''
      end

      def meta_desc
        @current_page['desc'] || ''
      end
	  	
      def menu
        App.settings.menus
  	  end

      def gacode
        App.settings.gacode
      end




      #EOC
    end
  end
end
