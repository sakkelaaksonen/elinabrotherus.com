class App
  module Views
    class Layout < Mustache
      def title
      @title || 'Welcome to'
      end
    end
  end
end
