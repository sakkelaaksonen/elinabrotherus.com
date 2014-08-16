class App
  module Views
    class Layout < Mustache

    # $this->setParam('PAGECLASS',$this->pageId);
    # $this->setParam('TITLE',$this->pageNode->title);
    # $this->setParam('NAVI',$this->generateNavi());
    # $this->setParam('KEYWORDS',$this->pageNode->meta->key);
    # $this->setParam('DESCRIPTION',$this->pageNode->meta->desc);


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

      #EOC
    end
  end
end
