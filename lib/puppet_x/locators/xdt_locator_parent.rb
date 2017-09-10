require_relative 'xdt_locator_logger'
require_relative '../xdt_xpath_reader'
require 'nokogiri'

class XdtLocatorParent
    def initialize(locator_arguments)
        @locator_arguments = locator_arguments
    end

    def locate(parent_source_node, locator_node)
        XdtLocatorLogger.log_action('Default', parent_source_node, locator_node, @locator_arguments)
        return [parent_source_node]
    end
end
