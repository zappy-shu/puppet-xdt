require 'puppet_x/xdt_namespace'
require 'puppet_x/locators/xdt_locator_factory'
require 'puppet_x/transforms/xdt_transform_factory'
require 'nokogiri'

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
            locator = nil
            xdt_attributes.each do |attr|
                if attr.is_transform?
                    transform = @transform_factory.create(attr)
                elsif attr.is_locator?
                    locator = @locator_factory.create(attr)
                end
            end

            locator = get_default_locator(transform) if locator.nil?

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

    private
    def get_default_locator(transform)
        if transform.is_a?(XdtTransformInsertAfter) || transform.is_a?(XdtTransformInsertBefore) || transform.is_a?(XdtTransformInsert)
            return XdtLocatorParent.new([])
        else
            return XdtLocatorDefault.new([])
        end
    end
end