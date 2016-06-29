module TorgApi
  class Base
    include TorgApi::Constants
    extend TorgApi::Constants
    REMOVE_HASH_ATTRS = [:@id]

    def to_h
      hash = {}
      vars = instance_variables
      REMOVE_HASH_ATTRS.each { |a| vars.delete(a) }

      vars.each { |var| hash[var.to_s.delete('@').to_sym] = instance_variable_get(var) }
      hash
    end

    def self.torg_resource
      @@torg_resource ||= RestClient::Resource.new(Settings.torg_url[:host], Settings.torg_url[:ssl])
    end
  end
end
