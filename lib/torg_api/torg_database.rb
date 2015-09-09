module TorgApi
  class TorgDatabase < ActiveRecord::Base
    self.abstract_class = true
  end
end
