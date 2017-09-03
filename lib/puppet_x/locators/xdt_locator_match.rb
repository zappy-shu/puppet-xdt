require_relative 'xdt_locator_logger'
require 'nokogiri'

class XdtLocatorMatch
    def locate(parent_source_node, locator_node, locator_arguments)
        XdtLocatorLogger.log_action('Match', parent_source_node, locator_node, locator_arguments)
    end
end
