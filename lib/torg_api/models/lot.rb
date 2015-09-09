module TorgApi
  module Models
    # Лот
    class Lot < TorgDatabase
      def to_api
        t = TorgApi::Api::Lot.new
        t.id = id
        t.num = num
        t
      end
    end
  end
end
