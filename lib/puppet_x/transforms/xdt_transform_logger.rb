require 'puppet/parser/functions'
require 'nokogiri'

class XdtTransformLogger
    def self.log_action(transform_type, source_node, transform_node, transform_arguments)
        source_node_path = source_node.path
        transform_node_path = transform_node.nil? ? nil : transform_node.path
        puts "Transform: #{transform_type}(args:'#{transform_arguments.join(',')}', source:'#{source_node_path}', transform:'#{transform_node_path}')"
    end
end