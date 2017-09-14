require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformInsertAfter
    def initialize(transform_arguments)
        @transform_arguments = transform_arguments
    end

    def transform(source_node, transform_node)
        XdtTransformLogger.log_action('InsertAfter', source_node, transform_node, @transform_arguments)
        transform_node_namespace = transform_node.namespace

        unless @transform_arguments.length == 1
            warn 'InsertAfter must have 1 argument that is the xpath of the node to insert before'
            return
        end

        xpath = @transform_arguments[0]
        insert_after_nodes = source_node.xpath(@transform_arguments[0])
        puts insert_after_nodes
        if insert_after_nodes.length == 0
            warn "Cannot find xpath '#{xpath}'"
            return
        end

        insert_after_node = insert_after_nodes[0]
        if insert_after_node == source_node.document.root
            warn 'Cannot InsertAfter root'
            return
        end

        insert_after_node.after(transform_node)
        transform_node.namespace = nil if transform_node_namespace.nil?
    end
end
