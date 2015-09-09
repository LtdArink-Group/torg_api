module TorgApi
  class TorgDatabase < ActiveRecord::Base
    self.abstract_class = true
    establish_connection :torg_db
  end
end
