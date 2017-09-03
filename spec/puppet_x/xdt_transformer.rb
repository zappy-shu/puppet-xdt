Dir[File.dirname(__FILE__) + '*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/locators/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/transforms/*.rb'].each {|file| require file }

class XdtTransformer
    def initialize(source_doc, transform_doc)
        @source_doc = source_doc
        @transform_doc = transform_doc

        @xdt_namspace = XdtNamespace.new
    end
end