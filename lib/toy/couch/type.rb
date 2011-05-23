module Toy
  module Couch
    module Type
      extend ActiveSupport::Concern
      
      module InstanceMethods
        def persisted_attributes
          super.merge("type"=>self.class.name)
        end
      end
    end
  end
end