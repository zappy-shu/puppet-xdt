require_relative 'xdt_locator_logger'
require_relative '../xdt_xpath_reader'
require 'nokogiri'

class XdtLocatorDefault
    def locate(parent_source_node, locator_node, locator_arguments)
        XdtLocatorLogger.log_action('Default', parent_source_node, locator_node, locator_arguments)
        xpath = XdtXpathReader.read_local(locator_node)
        return parent_source_node.xpath(xpath)
    end
end
