require 'toy'
require 'toy/couch/persistence'
require 'adapter/couch'


module Toy
  module Couch
    extend ActiveSupport::Concern

    included do
      include Persistence
    end
  end
end

Toy.plugin(Toy::Couch)
