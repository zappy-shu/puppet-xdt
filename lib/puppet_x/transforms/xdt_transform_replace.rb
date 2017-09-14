require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformReplace
    def initialize(transform_arguments)
        @transform_arguments = transform_arguments
    end

    def transform(source_node, transform_node)
        XdtTransformLogger.log_action('Replace', source_node, transform_node, @transform_arguments)
        transform_node_namespace = transform_node.namespace
        source_node.replace(transform_node)
        transform_node.namespace = nil if transform_node_namespace.nil?
    end
end
