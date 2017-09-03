require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformRemoveAttributes
    def transform(source_node, transform_node, tranform_arguments)
        XdtTransformLogger.log_action('RemoveAttributes', source_node, transform_node, tranform_arguments)
        if tranform_arguments.empty?
            source_node.xpath('@*').remove
        else
            source_node.attribute_nodes.each do |attr|
                attr.remove if tranform_arguments.include?(attr.name)
            end
        end
    end
end