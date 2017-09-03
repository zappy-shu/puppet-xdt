require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformSetAttributes
    def transform(source_node, transform_node, tranform_arguments)
        XdtTransformLogger.log_action('SetAttributes', source_node, transform_node, tranform_arguments)
        if tranform_arguments.empty?
            source_node.xpath('@*').remove
            transform_node.attribute_nodes.each { |attr| source_node[attr.name] = attr.value }
        else
            tranform_arguments.each do |name|
                if transform_node[name].nil?
                    warn "Transform node '#{transform_node.path}' does not contain attribute '#{name}'"
                else
                    source_node[name] = transform_node[name]
                end
            end
        end
    end
end