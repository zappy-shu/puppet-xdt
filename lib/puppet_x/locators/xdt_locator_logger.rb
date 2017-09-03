require 'nokogiri'

class XdtLocatorLogger
    def self.log_action(locator_type, source_node, locator_node, locator_arguments)
        source_node_path = source_node.path
        locator_node_path = locator_node.nil? ? nil : locator_node.path
        puts "#{locator_type}(args:'#{locator_arguments.join(',')}', source:'#{source_node_path}', locator:'#{locator_node_path}')"
    end
end