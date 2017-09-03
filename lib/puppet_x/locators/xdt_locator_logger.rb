require 'nokogiri'

class XdtLocatorLogger
    def self.log_action(locator_type, parent_source_node, locator_node, locator_arguments)
        parent_source_node_path = parent_source_node.path
        locator_node_path = locator_node.nil? ? nil : locator_node.path
        puts "#{locator_type}(args:'#{locator_arguments.join(',')}', parent source:'#{parent_source_node_path}', locator:'#{locator_node_path}')"
    end
end