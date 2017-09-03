require_relative 'xdt_locator_logger'
require 'nokogiri'

class XdtLocatorXpath
    def locate(source_node, locator_node, locator_arguments)
        XdtLocatorLogger.log_action('Xpath', source_node, locator_node, locator_arguments)
    end
end
