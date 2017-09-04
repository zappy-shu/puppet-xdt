require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformSetAttributes
    def initialize(transform_arguments)
        @transform_arguments = transform_arguments
    end

    def transform(source_node, transform_node)
        XdtTransformLogger.log_action('SetAttributes', source_node, transform_node, @transform_arguments)
        if @transform_arguments.empty?
            source_node.xpath('@*').remove
            transform_node.attribute_nodes.each { |attr| source_node[attr.name] = attr.value }
        else
            @transform_arguments.each do |name|
                if transform_node[name].nil?
                    warn "Transform node '#{transform_node.path}' does not contain attribute '#{name}'"
                else
                    source_node[name] = transform_node[name]
                end
            end
        end
    end
end