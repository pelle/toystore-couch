# encoding: utf-8
require 'couchrest'
require 'couchrest/design'

module Toy
  module Couch
    module DesignDoc
      extend ActiveSupport::Concern

      module ClassMethods

        def design_doc
          @design_doc ||= ::CouchRest::Design.new(default_design_doc)
        end

        def design_doc_id
          "_design/#{design_doc_slug}"
        end

        def design_doc_slug
          self.to_s
        end

        def design_doc_uri
          "#{store.client.root}/#{design_doc_id}"
        end

        # Retreive the latest version of the design document directly
        # from the database. This is never cached and will return nil if
        # the design is not present.
        #
        # Use this method if you'd like to compare revisions [_rev] which
        # is not stored in the normal design doc.
        def stored_design_doc
          store.client.get(design_doc_id)
        rescue RestClient::ResourceNotFound
          nil
        end

        # Save the design doc onto a target database in a thread-safe way,
        # not modifying the model's design_doc
        #
        # See also save_design_doc! to always save the design doc even if there
        # are no changes.
        def save_design_doc(force = false)
          update_design_doc(force)
        end

        # Force the update of the model's design_doc even if it hasn't changed.
        def save_design_doc!
          save_design_doc(true)
        end

        private

        # Writes out a design_doc to a given database if forced.
        #
        # Returns the original design_doc provided, but does 
        # not update it with the revision.
        def update_design_doc(force = false)
          return design_doc unless force

          # Load up the stored doc (if present), update, and save
          saved = stored_design_doc
          if saved
            saved.merge!(design_doc)
            store.client.save_doc(saved)
          else
            store.client.save_doc(design_doc)
            design_doc.delete('_rev') # Prevent conflicts, never store rev as db specific
          end

          design_doc
        end

        def default_design_doc
          {
            "_id" => design_doc_id,
            "language" => "javascript",
            "views" => {
              'all' => {
                'map' => "function(doc) {
                  if (doc['type'] == '#{self.to_s}') {
                    emit(doc['_id'],1);
                  }
                }"
              }
            }
          }
        end

      end # module ClassMethods

    end
  end
end