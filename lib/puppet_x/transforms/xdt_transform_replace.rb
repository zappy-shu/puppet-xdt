require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformReplace
    def transform(source_node, transform_node, tranform_arguments)
        XdtTransformLogger.log_action('Replace', source_node, transform_node, tranform_arguments)
        source_node.replace(transform_node)
    end
end
