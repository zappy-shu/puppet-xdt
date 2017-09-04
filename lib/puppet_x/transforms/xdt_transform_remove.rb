require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformRemove
    def initialize(transform_arguments)
        @transform_arguments = transform_arguments
    end

    def transform(source_node, transform_node)
        XdtTransformLogger.log_action('Remove', source_node, transform_node, @transform_arguments)
        source_node.remove
    end
end
