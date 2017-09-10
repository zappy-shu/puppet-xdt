require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformInsert
    def initialize(transform_arguments)
        @transform_arguments = transform_arguments
    end

    def transform(source_node, transform_node)
        XdtTransformLogger.log_action('Insert', source_node, transform_node, @transform_arguments)
        source_node.add_child(transform_node)
    end
end
