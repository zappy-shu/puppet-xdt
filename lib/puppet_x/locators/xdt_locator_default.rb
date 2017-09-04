require_relative 'xdt_locator_logger'
require_relative '../xdt_xpath_reader'
require 'nokogiri'

class XdtLocatorDefault
    def initialize(locator_arguments)
        @locator_arguments = locator_arguments
    end

    def locate(parent_source_node, locator_node)
        XdtLocatorLogger.log_action('Default', parent_source_node, locator_node, @locator_arguments)
        xpath = XdtXpathReader.read_local(locator_node)
        return parent_source_node.xpath(xpath)
    end
end
