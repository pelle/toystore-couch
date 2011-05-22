module Toy
  module Couch
    module Persistence
      extend ActiveSupport::Concern
      
      def initialize_from_database(attrs={})
        @_rev = attrs["_rev"]
        puts "initialize_from_database #{attrs.inspect}"
        super(attrs)
      end
      
      def persist!
        attrs = persisted_attributes
        attrs.delete('id') # no need to persist id as that is key
        attrs["_rev"] = @rev if @rev
        status = store.write(id, attrs)
        @_rev = status["rev"]
        puts "@rev= #{@_rev}"
        log_operation(:set, self.class.name, store, id, attrs)
        persist
        each_embedded_object { |doc| doc.send(:persist) }
        true
      end

    end
  end
end