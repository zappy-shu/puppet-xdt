require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformInsert
    def initialize(transform_arguments)
        @transform_arguments = transform_arguments
    end

    def transform(source_node, transform_node)
        XdtTransformLogger.log_action('Insert', source_node, transform_node, @transform_arguments)
        if (source_node.parent.nil? || source_node == source_node.document.root)
            warn "Source node '#{source_node.path}' does not have parent to insert '#{transform_node.path}'"
        else
            source_node.after(transform_node)
        end
    end
end
