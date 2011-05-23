require 'toy'
require 'toy/attributes'
require 'toy/couch/type'
require 'toy/couch/design_doc'
require 'toy/couch/views'
require 'adapter/couch'


module Toy
  module Couch
    extend ActiveSupport::Concern

    included do
      include DesignDoc
      include Views
    end
  end
end

Toy.plugin(Toy::Couch)
