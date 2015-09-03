module TorgApi
  class Settings
    @service_user = {}

    # Configure through hash
    def self.service_user_configure(opts = {})
      opts.each { |k, v| @service_user[k.to_sym] = v }
    end

    class << self
      attr_reader :service_user
    end
  end
end
