require 'nokogiri'

class XdtTransformLogger
    def self.log_action(transform_type, source_node, transform_node, transform_arguments)
        puts "#{transform_type}(#{transform_arguments.join(',')} source:'#{source_node.path}' transform:'#{transform_node.path}')"
    end
end