require_relative 'xdt_transform_logger'
require 'nokogiri'

class XdtTransformRemoveAttributes
    def initialize(transform_arguments)
        @transform_arguments = transform_arguments
    end

    def transform(source_node, transform_node)
        XdtTransformLogger.log_action('RemoveAttributes', source_node, transform_node, @transform_arguments)
        if @transform_arguments.empty?
            source_node.xpath('@*').remove
        else
            @transform_arguments.each do |arg|
                attr = source_node.attribute_nodes.select { |attr| attr.name == arg }
                if !attr.nil? && attr.length == 1
                    attr[0].remove
                else
                    warn "Source node '#{source_node.path}' does not contain attribute '#{arg}'"
                end
            end
        end
    end
end