module TorgApi
  class Settings
    @service_user = {}
    @torg_url = {}

    # Configure through hash
    def self.service_user_configure(opts = {})
      opts.each { |k, v| @service_user[k.to_sym] = v }
    end

    def self.torg_url_configure(opts = {})
      opts.each { |k,v| @torg_url[k.to_sym] = v }
    end

    class << self
      attr_reader :service_user
      attr_reader :torg_url
    end
  end
end
