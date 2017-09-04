Dir[File.dirname(__FILE__) + '*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/locators/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/transforms/*.rb'].each {|file| require file }

class XdtTransformer
    def initialize(source_doc, transform_doc)
        @source_doc = source_doc
        @transform_doc = transform_doc

        @xdt_namespace = XdtNamespace.new
        @locator_factory = XdtLocatorFactory.new
        @transform_factory = XdtTransformFactory.new
    end

    def transform
        walk_tree(@source_doc.root, @transform_doc.root) if @xdt_namespace.has_xdt_namespace?(@transform_doc)
        return @source_doc
    end

    private
    def walk_tree(source_node, transform_node)
        transform_node.elements.each do |transform_child|
            xdt_attributes = @xdt_namespace.get_xdt_attributes(@transform_doc, transform_child)
            transform = nil
            locator = XdtLocatorDefault.new([])
            xdt_attributes.each do |attr|
                if attr.is_transform?
                    transform = @transform_factory.create(attr)
                elsif attr.is_locator?
                    locator = @locator_factory.create(attr)
                end
            end

            @xdt_namespace.remove_xdt_attributes(@transform_doc, transform_child)
            sources = locator.locate(source_node, transform_child)
            sources.each do |source|
                transform.transform(source, transform_child) unless transform.nil?
                break if transform.is_a?(XdtTransformRemoveAll)
                next if transform.is_a?(XdtTransformRemove)
                walk_tree(source, transform_child)
            end
        end
    end
end