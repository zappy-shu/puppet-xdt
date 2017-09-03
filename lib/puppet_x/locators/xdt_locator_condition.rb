require_relative 'xdt_locator_logger'
require 'nokogiri'

class XdtLocatorCondition
    def locate(source_node, locator_node, locator_arguments)
        XdtLocatorLogger.log_action('Condition', source_node, locator_node, locator_arguments)
    end
end
