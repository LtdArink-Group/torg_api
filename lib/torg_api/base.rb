module TorgApi
  class Base
    include TorgApi::Constants
    extend TorgApi::Constants
    REMOVE_HASH_ATTRS = [:@id]

    class << self
      def attr_accessor(*vars)
        @attributes ||= []
        @attributes.concat vars
        super(*vars)
      end

      def attributes
        @attributes
      end

      def torg_resource
        @@torg_resource ||= RestClient::Resource.new(Settings.torg_url[:host], Settings.torg_url[:ssl])
      end
    end

    def initialize(args = {})
      self.class.attributes.each do |attribute|
        self.send("#{attribute}=", args[attribute]) if args.key?(attribute)
      end
    end

    def to_h
      hash = {}
      vars = instance_variables
      REMOVE_HASH_ATTRS.each { |a| vars.delete(a) }

      vars.each { |var| hash[var.to_s.delete('@').to_sym] = instance_variable_get(var) }
      hash
    end
  end
end
