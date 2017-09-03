require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformRemoveAttributes
    def transform(source_node, transform_node, tranform_arguments)
        XdtTransformLogger.log_action('RemoveAttributes', source_node, transform_node, tranform_arguments)
        source_node.xpath('@*').remove
    end
end