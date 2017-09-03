require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformRemoveAll
    def transform(source_node, transform_node, transform_arguments)
        XdtTransformLogger.log_action('RemoveAll', source_node, transform_node, transform_arguments)
        source_node.parent.elements.select { |node| node.name == transform_node.name }.each { |node| node.remove }
    end
end
