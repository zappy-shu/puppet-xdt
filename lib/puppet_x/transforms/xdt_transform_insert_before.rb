require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformInsertBefore
    def transform(source_node, transform_node, transform_arguments)
        XdtTransformLogger.log_action('InsertBefore', source_node, transform_node, transform_arguments)
        unless transform_arguments.length == 1
            warn 'InsertBefore must have 1 argument that is the xpath of the node to insert before'
            return
        end

        xpath = transform_arguments[0]
        insert_before_nodes = source_node.xpath(transform_arguments[0])
        if insert_before_nodes.length == 0
            warn "Cannot find xpath '#{xpath}'"
            return
        end

        insert_before_node = insert_before_nodes[0]
        if insert_before_node == source_node.document.root
            warn 'Cannot InsertBefore root'
            return
        end

        insert_before_node.before(transform_node)
    end
end
